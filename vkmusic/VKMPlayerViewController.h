//
//  VKMPlayerViewController.h
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKMPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
- (IBAction)playPressed:(id)sender;
- (IBAction)stopPressed:(id)sender;
- (IBAction)previousPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)downloadPressed:(id)sender;

@end
