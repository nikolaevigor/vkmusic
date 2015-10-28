//
//  VKMEqualizerViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMEqualizerViewController.h"

@interface VKMEqualizerViewController ()

@end

@implementation VKMEqualizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lowPassValueChanged:(id)sender {
    NSLog(@"Value changed for lowPassSlider");
}

- (IBAction)highPassValueChanged:(id)sender {
    NSLog(@"Value changed for highPassSlider");
}

- (IBAction)peakingValueChanged:(id)sender {
    NSLog(@"Value changed for peakingSlider");
}

- (IBAction)lowShelfValueChanged:(id)sender {
    NSLog(@"Value changed for lowShelfSlider");
}

- (IBAction)highShelfValueChanged:(id)sender {
    NSLog(@"Value changed for highPassSlider");
}
@end
