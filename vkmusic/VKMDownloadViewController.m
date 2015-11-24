//
//  VKMDownloadViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMDownloadViewController.h"

@interface VKMDownloadViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, VKSdkDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@property (strong, nonatomic) NSMutableArray *results;

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
    [VKSdk initializeWithDelegate:self andAppId:@"5152277"];
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
    self.results = [VKManager getTitlesForSearchQuery: self.searchBox.text];
    [self.tableView reloadData];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = self.results[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
