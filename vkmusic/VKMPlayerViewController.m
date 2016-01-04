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
#import "AppDelegate.h"

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
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)playPressed:(id)sender {
    [self.delegate resume];
}

- (IBAction)pauseButton:(id)sender {
    [self.delegate pause];
}

- (IBAction)stopButton:(id)sender {
    [self.delegate stop];
}

- (IBAction)previousPressed:(id)sender {
    [self.delegate playPrevious];
}

- (IBAction)nextPressed:(id)sender {
    [self.delegate playNext];
}


@end
