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

@interface VKMSongsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation VKMSongsViewController
{
    BOOL isFiltered;
    NSMutableArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tracks = [VKMFileManager loadTracksFromEntity:@"Track"];
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
        return [self.tracks count];
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
        node = self.tracks[indexPath.row];
    }
    [(SongsTableViewCell *)cell titleLabel].text = [node name];
    [(SongsTableViewCell *)cell artistLabel].text = [node artist];
    [(SongsTableViewCell *)cell durationLabel].text = [self timeFormatted:(int)[node duration]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = [self.tracks objectAtIndex:indexPath.row];
    
    [self.player stop];
    NSURL *url = [NSURL fileURLWithPath:[node path]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
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

#pragma mark - Player Delegate methods

- (void)play{
    [self.player play];
}

- (void)stop{
    [self.player stop];
    [self.player setCurrentTime:0.0];
}

- (void)pause{
    [self.player pause];
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
        
        for (VKMAudioNode *track in self.tracks)
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

@end
