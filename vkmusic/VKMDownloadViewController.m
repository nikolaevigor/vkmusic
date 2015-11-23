//
//  VKMDownloadViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMDownloadViewController.h"

@interface VKMDownloadViewController () <UITableViewDataSource, UITableViewDelegate, VKSdkDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VKMDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [VKSdk initializeWithDelegate:self andAppId:@"5152277"];
    [VKSdk authorize:@[@"friends", @"audio"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = @"Song name";
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - VKSdk Delegate methods

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError
{
    NSLog(@"User denied access");
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken
{
    
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken
{
    NSLog(@"Received new token");
}

@end
