//
//  VKMAudioNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMMediaNode.h"

@interface VKMAudioNode : VKMMediaNode

// Duration of the audio. Can not be 0.
@property (nonatomic) NSTimeInterval duration;
// Audio ID in vk database.
@property(readonly, nonatomic) NSUInteger audioId;
// Owner ID of the audio.
@property(readonly, nonatomic) NSUInteger ownderId;
// Artist's name. Can not be nil.
@property(nonatomic, nonnull) NSString *artist;

//@bried designated initializer
- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                type:(nonnull NSString *)type
                                size:(NSUInteger)size
                              artist:(nonnull NSString *)artist
                            duration:(NSTimeInterval) duration;

// Prohibited
- (nonnull instancetype) initWithName:(nonnull NSString *)name type:(nonnull NSString *)type size:(NSUInteger)size __unavailable;

@end
