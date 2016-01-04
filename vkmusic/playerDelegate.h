//
//  playerDelegate.h
//  vkmusic
//
//  Created by Igor Nikolaev on 13/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

@class VKMAudioNode;

@protocol playerDelegate <NSObject>

@required

- (void)play:(NSArray *)tracks startingFrom:(NSInteger)initialTrack;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)playNext;
- (void)playPrevious;

@end
