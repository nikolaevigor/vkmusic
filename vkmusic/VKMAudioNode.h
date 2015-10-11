//
//  VKMAudioNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMMediaNode.h"

@interface VKMAudioNode : VKMMediaNode

/// Duration of the audio. Can not be nil.
@property (nonatomic, nonnull) NSTimeInterval *duration;

- (void)play;
- (void)pause;
- (void)stop;

@end
