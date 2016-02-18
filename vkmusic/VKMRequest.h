//
//  VKMRequest.h
//  vkmusic
//
//  Created by Igor Nikolaev on 17/02/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKMRequest : NSObject

+ (void)sendAudioSearchRequestForKey:(NSString *)query completion:(void (^) (id))completion error:(void (^) (void))error;
+ (void)sendAudioSearchRequestForKey:(NSString *)query
                              offset:(NSString *)offset
                               count:(NSString *)count
                       auto_complete:(NSString *)auto_complete
                              lyrics:(NSString *)lyrics
                      performer_only:(NSString *)performer_only
                                sort:(NSString *)sort
                          search_own:(NSString *)search_own
                          completion:(void (^) (id))completion
                               error:(void (^) (void))error;

@end
