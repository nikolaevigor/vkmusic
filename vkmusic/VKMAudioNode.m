//
//  VKMAudioNode.m
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioNode.h"

@implementation VKMAudioNode

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                type:(nonnull NSString *)type
                                size:(NSUInteger)size
                              artist:(nonnull NSString *)artist
                            duration:(NSTimeInterval)duration
{
    if ((artist.length == 0) || (artist == nil)) {
        [NSException raise:@"Invalid artist value" format:@"name of %@ is invalid", artist];
    }
    if (duration == 0) {
        [NSException raise:@"Invalid duration value" format:@"name of %ld is invalid", (long)duration];
    }
    if (self = [super initWithName:name type:type size:size])
    {
        _artist = artist;
        _duration = duration;
    }
    return self;
}

@end
