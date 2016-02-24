//
//  VKManager.h
//  vkmusic
//
//  Created by Igor Nikolaev on 24/11/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKManager : NSObject

+ (void)getTitlesForSearchQuery:(NSString *)query completion:(void (^) (NSMutableArray *))completion;
+ (void)getTitlesForSearchQuery:(NSString *)query offset:(NSString *)offset count:(NSString *)count completion:(void (^)(NSMutableArray *))completion;
+ (void)getTitlesForSearchQuery:(NSString *)query
                         offset:(NSString *)offset
                          count:(NSString *)count
                  auto_complete:(NSString *)auto_complete
                         lyrics:(NSString *)lyrics
                 performer_only:(NSString *)performer_only
                           sort:(NSString *)sort
                     search_own:(NSString *)search_own
                     completion:(void (^)(NSMutableArray *))completion;

@end
