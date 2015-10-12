//
//  VKMNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKMNode : NSObject

// Name of the node. Its length always more than 0.
@property (nonatomic, nonnull) NSString *name;

// @brief The designated initializer.
// @param name Length should be greater than 0.
- (nonnull instancetype)initWithName:(nonnull NSString *)name;

// Forbid using init to prevent initializing without name.
- (nonnull instancetype)init __attribute__((unavailable("init not available")));

@end
