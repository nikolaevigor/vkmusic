//
//  VKMTracklist.m
//  vkmusic
//
//  Created by Igor Nikolaev on 18/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMTracklist.h"

@implementation VKMTracklist

- (nonnull instancetype)initWithNode:(VKMAudioNode *)node
{
    if (self = [super init])
    {
        _tracklist = [[NSArray alloc] initWithObjects:node, nil];
    }
    return self;
}

- (nonnull instancetype)initWithNodes:(NSArray *)nodes
{
    if (self = [super init])
    {
        _tracklist = [nodes copy];
    }
    return self;
}

@end
