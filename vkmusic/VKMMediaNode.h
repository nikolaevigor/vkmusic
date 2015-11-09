//
//  VKMMediaNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMNode.h"

@interface VKMMediaNode : VKMNode

// Size of the media. Can not be 0.
@property (nonatomic) NSUInteger size;

// Type of the media. Can not be nil.
@property (nonatomic, nonnull) NSString *type;

// Designated initializer
- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                type:(nonnull NSString *)type
                                size:(NSUInteger)size;

// Prohibited
- (nonnull instancetype) initWithName:(nonnull NSString *)name __unavailable;

@end
