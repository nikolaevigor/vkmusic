//
//  VKMSettingsViewController.h
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKMSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UISwitch *equTrigger;
@property (weak, nonatomic) IBOutlet UISwitch *cacheTrigger;
@property (weak, nonatomic) IBOutlet UIButton *deleteSongsButton;
- (IBAction)equTriggerd:(id)sender;
- (IBAction)cacheTriggered:(id)sender;
- (IBAction)logoutPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;

@end
