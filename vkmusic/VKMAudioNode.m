//
//  VKMAudioNode.m
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioNode.h"

@implementation VKMAudioNode

- (nonnull instancetype)initWithName:(NSString *)name Artist:(NSString *)artist
{
    if ((name.length == 0) || (name == nil)) {
        [NSException raise:@"Invalid name value" format:@"name of %@ is invalid", name];
    }
    
    if ((artist.length == 0) || (artist == nil)) {
        [NSException raise:@"Invalid artist value" format:@"name of %@ is invalid", artist];
    }
    
    self.name = [name copy];
    self.artist = [artist copy];
    
    return self;
}

- (void)play{
    
}

- (void)pause{
    
}

- (void)stop{
    
}

@end
