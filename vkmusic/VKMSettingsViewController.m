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
    [VKSdk forceLogout];
}

- (IBAction)deletePressed:(id)sender {
    [VKMFileManager deleteAllEntities:@"Track"];
    [VKMFileManager emptyDocumentsFolder];
}
@end
