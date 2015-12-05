//
//  VKManager.h
//  vkmusic
//
//  Created by Igor Nikolaev on 24/11/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKSdk.h"

@interface VKManager : NSObject

+ (void)getTitlesForSearchQuery:(NSString *)query completion:(void (^) (NSMutableArray *))completion;

@end
