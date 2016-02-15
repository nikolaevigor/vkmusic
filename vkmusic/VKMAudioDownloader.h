//
//  VKMAudioDownloader.h
//  vkmusic
//
//  Created by Igor Nikolaev on 15/02/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKMAudioDownloader : NSObject

+ (void)downloadSong:(NSString *)songURL
               store:(NSString *)path
            progress:(void (^) (double))progress
          completion:(void (^) (BOOL))completion;

@end
