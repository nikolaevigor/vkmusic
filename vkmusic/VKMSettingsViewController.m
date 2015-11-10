//
//  VKMSettingsViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMSettingsViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)equTriggerd:(id)sender {
    NSLog(@"equ");
}

- (IBAction)cacheTriggered:(id)sender {
    NSLog(@"cache");
}

- (IBAction)logoutPressed:(id)sender {
    NSLog(@"logout");
}

- (IBAction)deletePressed:(id)sender {
    NSLog(@"delete");
}
@end
