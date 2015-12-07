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

@interface VKMDownloadViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (strong, nonatomic) NSArray *tracks;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation VKMDownloadViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBox.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.progressView setProgress:0];
    [self.progressView setHidden:YES];
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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    VKMAudioNode *node = self.tracks[indexPath.row];
    
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = [node name];
    
    if ([node isDownloaded]) {
        cell.backgroundColor = [UIColor greenColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKMAudioNode *node = (VKMAudioNode *)self.tracks[indexPath.row];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/%@-%@", [paths objectAtIndex:0], [node artist], [node name]];
    
    if (!node.isDownloaded)
    {
        [VKMAudioNodeDownloader downloadNode:node
                                       store:documentsDirectory
                             withProgressBar:self.progressView
                                  completion:^void (BOOL result) {
                                      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                      if (result) {
                                          cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                          cell.backgroundColor = [UIColor greenColor];
                                      }
                                      else
                                      {
                                          cell.backgroundColor = [UIColor whiteColor];
                                      }
                                  }];
    }
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
