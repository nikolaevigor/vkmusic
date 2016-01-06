//
//  VKMEqualizerViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMEqualizerViewController.h"
#import "playerDelegate.h"
#import "AppDelegate.h"

@interface VKMEqualizerViewController ()

@property (weak, nonatomic) IBOutlet UISlider *firstSlider;
@property (weak, nonatomic) IBOutlet UISlider *secondSlider;
@property (weak, nonatomic) IBOutlet UISlider *thirdSlider;
@property (weak, nonatomic) IBOutlet UISlider *forthSlider;
@property (weak, nonatomic) IBOutlet UISlider *fifthSlider;
@property (weak, nonatomic) IBOutlet UISlider *sixthSlider;

@property (weak, nonatomic) id <playerDelegate> delegate;

@end

@implementation VKMEqualizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)firstSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.firstSlider.value forBand:0];
}
- (IBAction)secondSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.secondSlider.value forBand:1];
}
- (IBAction)thirdSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.thirdSlider.value forBand:2];
}
- (IBAction)forthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.forthSlider.value forBand:3];
}
- (IBAction)fifthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.fifthSlider.value forBand:4];
}
- (IBAction)sixthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:self.sixthSlider.value forBand:5];
}
@end
