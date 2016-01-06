//
//  VKMPlayer.h
//  vkmusic
//
//  Created by Igor Nikolaev on 02/01/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKMAudioNode.h"

@interface VKMPlayer : NSObject

- (void)play:(NSArray *)tracks startingFrom:(NSInteger)initialTrack;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)playNext;
- (void)playPrevious;
- (void)setEqualizerWithGain:(float)gain forBand:(int)band;
- (void)resetEQU;
- (NSArray *)getCurrentEQUFrequenciesSet;

@end
