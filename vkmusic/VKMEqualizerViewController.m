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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *frequencies = [self.delegate getCurrentEQUFrequenciesSet];
    self.firstSlider.value = [frequencies[0] floatValue];
    self.secondSlider.value = [frequencies[1] floatValue];
    self.thirdSlider.value = [frequencies[2] floatValue];
    self.forthSlider.value = [frequencies[3] floatValue];
    self.fifthSlider.value = [frequencies[4] floatValue];
    self.sixthSlider.value = [frequencies[5] floatValue];
}

- (IBAction)firstSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.firstSlider.value) forBand:0];
}
- (IBAction)secondSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.secondSlider.value) forBand:1];
}
- (IBAction)thirdSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.thirdSlider.value) forBand:2];
}
- (IBAction)forthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.forthSlider.value) forBand:3];
}
- (IBAction)fifthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.fifthSlider.value) forBand:4];
}
- (IBAction)sixthSliderValueChanged:(id)sender {
    [self.delegate setEqualizerWithGain:roundf(self.sixthSlider.value) forBand:5];
}
@end
