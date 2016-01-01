//
//  VKMSettingsViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMSettingsViewController.h"
#import "VKSdk.h"
#import "VKMFileManager.h"

@interface VKMSettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UISwitch *equTrigger;
@property (weak, nonatomic) IBOutlet UISwitch *cacheTrigger;
@property (weak, nonatomic) IBOutlet UIButton *deleteSongsButton;

@end

@implementation VKMSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)equTriggerd:(id)sender {
    NSLog(@"equ");
}

- (IBAction)cacheTriggered:(id)sender {
    NSLog(@"cache");
}

- (IBAction)logoutPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirmation"
                                                                   message:@"Are you sure?"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    CGRect logoutButtonFrame = self.logoutButton.frame;
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(logoutButtonFrame.origin.x + logoutButtonFrame.size.width, logoutButtonFrame.origin.y + logoutButtonFrame.size.height / 2.0, 0, 0);
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Yes"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              [VKSdk forceLogout];
                                                          }];
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               NSLog(@"Logout escaped");
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)deletePressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirmation"
                                                                   message:@"Are you sure?"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    CGRect deleteSongsButtonFrame = self.deleteSongsButton.frame;
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(deleteSongsButtonFrame.origin.x, deleteSongsButtonFrame.origin.y + deleteSongsButtonFrame.size.height / 2.0, 0, 0);
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Yes"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              [VKMFileManager deleteAllFilesForEntity:@"Track"];
                                                              [VKMFileManager deleteAllItemsForEntity:@"Track"];
                                                          }];
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               NSLog(@"Deletion escaped");
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
