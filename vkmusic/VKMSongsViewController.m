//
//  VKMSearchViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMSongsViewController.h"
#import "VKMFileManager.h"
#import "AVFoundation/AVFoundation.h"
#import "VKMAudioNode.h"
#import "SongsTableViewCell.h"
#import "playerDelegate.h"
#import "VKMPlayer.h"
#import "AppDelegate.h"

@interface VKMSongsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <playerDelegate> delegate;

@end

@implementation VKMSongsViewController
{
    BOOL isFiltered;
    NSMutableArray *searchResults;
    NSMutableArray *tracks;
}

- (void)viewDidLoad
{
    self.searchBox.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated{
    tracks = [[VKMFileManager loadTracksFromEntity:@"Track"] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered)
    {
        return searchResults.count;
    }
    else
    {
        return [tracks count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SongsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID2"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SongsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReuseID2"];
        cell = (SongsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReuseID2"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node;
    if (isFiltered)
    {
        node = searchResults[indexPath.row];
    }
    else
    {
        node = tracks[indexPath.row];
    }
    [(SongsTableViewCell *)cell titleLabel].text = [node name];
    [(SongsTableViewCell *)cell artistLabel].text = [node artist];
    [(SongsTableViewCell *)cell durationLabel].text = [self timeFormatted:(int)[node duration]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate play:tracks startingFrom:indexPath.row];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView indexPathForSelectedRow] isEqual:indexPath]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate pause];
        return nil;
    }
    return indexPath;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Fav" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSLog(@"Fav");
    }];
    editAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        VKMAudioNode *node;
        if (isFiltered)
        {
            node = searchResults[indexPath.row];
            [searchResults removeObjectAtIndex:indexPath.row];
        }
        else
        {
            node = tracks[indexPath.row];
            [tracks removeObjectAtIndex:indexPath.row];
        }
        [self removeItem:indexPath];
        [VKMFileManager deleteFileForNode:node];
        [VKMFileManager deleteNode:node forEntity:@"Track"];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - Text Field methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Search Bar methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        isFiltered = YES;
        
        searchResults = [[NSMutableArray alloc] init];
        
        for (VKMAudioNode *track in tracks)
        {
            NSRange trackRange = [track.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (trackRange.location != NSNotFound)
            {
                [searchResults addObject:track];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBox resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBox resignFirstResponder];
}

#pragma mark - "Nice snippets"

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    if (hours == 0) {
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
    else {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    }
}

- (void)removeItem:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

@end
