//
//  VKMMediaNode.m
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMMediaNode.h"

@implementation VKMMediaNode

- (nonnull instancetype)initWithName:(nonnull NSString *)name type:(nonnull NSString *)type size:(NSUInteger)size
{
    if ((type.length == 0) || (type == nil)) {
        [NSException raise:@"Invalid type value" format:@"name of %@ is invalid", type];
    }
    if (size == 0) {
        [NSException raise:@"Invalid size value" format:@"name of %ld is invalid", (long)size];
    }
    if (self = [super initWithName:name])
    {
        _type = [type copy];
        _size = size;
    }
    return self;
}

@end
