//
//  VKMAudioNodeDownloader.h
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VKMAudioNode.h"
#import "AFNetworking.h"

@interface VKMAudioNodeDownloader : NSObject

+ (void)downloadNode:(VKMAudioNode *)node
               store:(NSString *)path
            progress:(void (^) (double))progress
          completion:(void (^) (BOOL))completion;

@end
