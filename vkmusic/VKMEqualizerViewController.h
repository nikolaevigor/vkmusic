//
//  VKMEqualizerViewController.h
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKMEqualizerViewController : UIViewController

- (IBAction)lowPassValueChanged:(id)sender;
- (IBAction)highPassValueChanged:(id)sender;
- (IBAction)peakingValueChanged:(id)sender;
- (IBAction)lowShelfValueChanged:(id)sender;
- (IBAction)highShelfValueChanged:(id)sender;

@end
