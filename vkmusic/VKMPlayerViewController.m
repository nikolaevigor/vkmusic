//
//  VKMPlayerViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VKMPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation VKMPlayerViewController

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

- (IBAction)playPressed:(id)sender {
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *path = [documentsPath objectAtIndex:0];
    NSArray *songs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *songPath = [NSString stringWithFormat:@"%@/%@", path, songs[3]];
    NSURL *url = [NSURL fileURLWithPath:songPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    
}

- (IBAction)stopPressed:(id)sender {
    [self.player stop];
}

- (IBAction)previousPressed:(id)sender {
    NSLog(@"Pressed");
}

- (IBAction)nextPressed:(id)sender {
    NSLog(@"Pressed");
}

- (IBAction)downloadPressed:(id)sender {
    NSLog(@"Pressed");
}
@end
