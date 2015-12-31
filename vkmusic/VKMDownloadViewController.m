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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![VKSdk wakeUpSession])
    {
        [VKSdk authorize:@[@"friends", @"audio"]];
    }
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
    [self paintCell:cell inColor:[UIColor colorWithRed:118.0/255.0 green:234.0/255.0 blue:128.0/255.0 alpha:1] if:[node isDownloaded]];
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

#pragma mark - VKSdk Delegate methods

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    NSLog(@"Should present view controller");
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    NSLog(@"Need captcha enter");
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError
{
    NSLog(@"User denied access");
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken
{
    NSLog(@"Token expired");
    VKAccessToken *token = [VKSdk getAccessToken];
    [VKSdk setAccessToken:token];
    [token saveTokenToDefaults:@"token"];
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken
{
    NSLog(@"Received new token");
    [newToken saveTokenToDefaults:@"token"];
}


@end
