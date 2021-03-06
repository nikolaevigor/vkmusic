//
//  VKMDownloadViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SVPullToRefresh.h"
#import "AppDelegate.h"
#import "VKMDownloadViewController.h"
#import "VKSdk.h"
#import "AFNetworking.h"
#import "VKManager.h"
#import "VKMAudioNodeDownloader.h"
#import "DownloadTableViewCell.h"

@interface VKMDownloadViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSMutableDictionary *downloadingCells;

@end

@implementation VKMDownloadViewController

- (void)viewDidLoad
{
    self.downloadingCells = [[NSMutableDictionary alloc] init];
    self.searchBox.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    //setting infinite scrolling
    __block NSString *queryText;
    __block NSUInteger counter;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if (!queryText | ![queryText isEqualToString:self.searchBox.text]) {
            queryText = self.searchBox.text;
            counter = 1;
        }
        else
        {
            counter += 1;
        }
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.tableView beginUpdates];
            [VKManager getTitlesForSearchQuery:self.searchBox.text
                                        offset:[NSString stringWithFormat:@"%lu", counter*30]
                                         count:@"30"
                                    completion:^void (NSMutableArray *tracks)
             {
                 self.tracks = [self.tracks arrayByAddingObjectsFromArray:tracks];
                 [self.tableView reloadData];
             }];
            [self.tableView endUpdates];
            
            [self.tableView.infiniteScrollingView stopAnimating];
        });
    }];
    
    [self.tableView triggerPullToRefresh];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![VKSdk wakeUpSession])
    {
        [VKSdk authorize:@[@"friends", @"audio"]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - Search Bar methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __block void (^completion) (NSMutableArray *) = ^(NSMutableArray * tracks){self.tracks = tracks; [self.tableView reloadData];};
    [VKManager getTitlesForSearchQuery:self.searchBox.text completion:completion];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
    if (!cell || cell.isDownloading)
    {
        [tableView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReuseID"];
        cell = (DownloadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
    }
    if ([self.downloadingCells objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]])
    {
        cell = [self.downloadingCells objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = self.tracks[indexPath.row];
    [(DownloadTableViewCell *)cell titleLabel].text = [node name];
    [(DownloadTableViewCell *)cell artistLabel].text = [node artist];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[node path]])
    {
        cell.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:234.0/255.0 blue:128.0/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [(DownloadTableViewCell *)cell progressBar].progress = 1.0;
        node.isDownloaded = YES;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (![(DownloadTableViewCell *)cell isDownloading])
        {
            [(DownloadTableViewCell *)cell progressBar].progress = 0.0;
        }
        node.isDownloaded = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = (VKMAudioNode *)self.tracks[indexPath.row];
    
    NSString *formattedArtist = [[node artist] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSString *formattedName = [[node name] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/%@-%@", [paths objectAtIndex:0], formattedArtist, formattedName];
    
    DownloadTableViewCell *cell = (DownloadTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!node.isDownloaded)
    {
        [VKMAudioNodeDownloader downloadNode:node
                                       store:documentsDirectory
                                    progress:^void (double progressValue)
         {
             cell.progressBar.progress = (double)progressValue;
         }
                                  completion:^void (BOOL result)
         {
             [self paintCell:cell inColor:[UIColor colorWithRed:118.0/255.0 green:234.0/255.0 blue:128.0/255.0 alpha:1] if:result];
             cell.isDownloading = NO;
             [self.downloadingCells removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
             cell.userInteractionEnabled = YES;
         }];
        cell.isDownloading = YES;
        cell.userInteractionEnabled = NO;
        [self.downloadingCells setObject:cell forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)paintCell:(UITableViewCell *)cell inColor:(UIColor *)color if:(BOOL)condition
{
    if (condition) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = color;
        [(DownloadTableViewCell *)cell progressBar].progress = 1.0;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        [(DownloadTableViewCell *)cell progressBar].progress = 0;
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark - Text Field methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
