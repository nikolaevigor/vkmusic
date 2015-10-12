//
//  VKMMediaNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMNode.h"

@interface VKMMediaNode : VKMNode

// Size of the media. Can not be nil.
@property (nonatomic, nonnull) NSUInteger *size;

// Type of the media. Can not be nil.
@property (nonatomic, nonnull) NSString *type;

@end
