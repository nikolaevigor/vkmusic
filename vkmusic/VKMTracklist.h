//
//  VKMTracklist.h
//  vkmusic
//
//  Created by Igor Nikolaev on 18/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKMAudioNode.h"

@interface VKMTracklist : NSObject

@property (nonatomic, strong, nonnull) NSArray *tracklist;

- (nonnull instancetype)initWithNode:(nonnull VKMAudioNode *)node;
- (nonnull instancetype)initWithNodes:(nonnull NSArray *)nodes;

// Prohibited
- (nonnull instancetype)init __unavailable;
+ (nonnull instancetype)new __unavailable;

@end
