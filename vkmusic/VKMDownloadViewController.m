//
//  VKMDownloadViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "VKMDownloadViewController.h"
#import "VKSdk.h"
#import "AFNetworking.h"
#import "VKManager.h"
#import "VKMAudioNodeDownloader.h"
#import "DownloadTableViewCell.h"

@interface VKMDownloadViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (strong, nonatomic) NSArray *tracks;

@end

@implementation VKMDownloadViewController

- (void)viewDidAppear:(BOOL)animated {
    if (![VKSdk wakeUpSession])
    {
        [VKSdk authorize:@[@"friends", @"audio"]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Text Field Events methods

- (IBAction)searchBoxEditingDidBegin:(id)sender {
    self.searchBox.text = @"";
}

- (IBAction)searchBoxEditingDidEnd:(id)sender {
    __block void (^completion) (NSMutableArray *) = ^(NSMutableArray * tracks){self.tracks = tracks; [self.tableView reloadData];};
    [VKManager getTitlesForSearchQuery:self.searchBox.text completion:completion];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReuseID"];
        cell = (DownloadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
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
        node.isDownloaded = YES;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        [(DownloadTableViewCell *)cell progressBar].progress = 0.0;
        node.isDownloaded = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = (VKMAudioNode *)self.tracks[indexPath.row];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/%@-%@", [paths objectAtIndex:0], [node artist], [node name]];
    
    DownloadTableViewCell *cell = (DownloadTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!node.isDownloaded)
    {
        [VKMAudioNodeDownloader downloadNode:node
                                       store:documentsDirectory
                                    progress:^void (double progressValue) {
                                        cell.progressBar.progress = (double)progressValue;
                                    }
                                  completion:^void (BOOL result) {
                                      [self paintCell:cell inColor:[UIColor colorWithRed:118.0/255.0 green:234.0/255.0 blue:128.0/255.0 alpha:1] if:result];
                                  }];
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
