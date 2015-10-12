//
//  VKMAudioNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMMediaNode.h"

@interface VKMAudioNode : VKMMediaNode

// Duration of the audio. Can not be nil.
@property (nonatomic, nonnull) NSTimeInterval *duration;
// Audio ID in vk database.
@property(readonly, nonatomic) NSUInteger audioId;
// Owner ID of the audio.
@property(readonly, nonatomic) NSUInteger ownderId;
// Artist's name. Can not be nil.
@property(nonatomic, nonnull) NSString* artist;

//@bried designated initializer
//@param Name and artist can not be 0.
- (nonnull instancetype)initWithName:(nonnull NSString *)name Artist:(nonnull NSString *)artist;

- (nonnull instancetype)initWithName:(nonnull NSString *)name __attribute__((unavailable("initWithName: not available")));

- (void)play;
- (void)pause;
- (void)stop;

@end
