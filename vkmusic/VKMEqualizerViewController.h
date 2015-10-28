//
//  VKMEqualizerViewController.h
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKMEqualizerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *lowPassSlider;
@property (weak, nonatomic) IBOutlet UISlider *highPassSlider;
@property (weak, nonatomic) IBOutlet UISlider *peakingSlider;
@property (weak, nonatomic) IBOutlet UISlider *lowShelfSlider;
@property (weak, nonatomic) IBOutlet UISlider *highShelfSlider;

- (IBAction)lowPassValueChanged:(id)sender;
- (IBAction)highPassValueChanged:(id)sender;
- (IBAction)peakingValueChanged:(id)sender;
- (IBAction)lowShelfValueChanged:(id)sender;
- (IBAction)highShelfValueChanged:(id)sender;

@end
