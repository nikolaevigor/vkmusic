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

@interface VKMSongsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation VKMSongsViewController

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
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self.tracks[indexPath.row] name];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = [self.tracks objectAtIndex:indexPath.row];
    
    [self.player stop];
    NSURL *url = [NSURL fileURLWithPath:[node path]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
}

#pragma mark - Text Field Events methods

- (IBAction)searchBoxEditingDidBegin:(id)sender {
    self.searchTextField.text = @"";
}

- (IBAction)searchBoxEditingDidEnd:(id)sender {
    
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

@end
