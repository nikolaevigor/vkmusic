//
//  VKMNode.m
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMNode.h"

@implementation VKMNode

- (nonnull instancetype)initWithName:(NSString *)name
{
    if ((name.length == 0) || (name == nil)) {
        [NSException raise:@"Invalid name value" format:@"name of %@ is invalid", name];
    }
    if (self = [super init])
    {
        _name = [name copy];
    }
    return self;
}

@end

