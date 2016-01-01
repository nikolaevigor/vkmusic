//
//  VKMPlayerViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "playerDelegate.h"

@interface VKMPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) id <playerDelegate> delegate;

@end

@implementation VKMPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = [(UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController viewControllers][1];
}

- (IBAction)playPressed:(id)sender {
    [self.delegate play];
}

- (IBAction)pauseButton:(id)sender {
    [self.delegate pause];
}

- (IBAction)stopButton:(id)sender {
    [self.delegate stop];
}

- (IBAction)previousPressed:(id)sender {
    NSLog(@"Pressed");
}

- (IBAction)nextPressed:(id)sender {
    NSLog(@"Pressed");
}


@end
