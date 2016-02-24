//
//  VKMRequest.m
//  vkmusic
//
//  Created by Igor Nikolaev on 17/02/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import "VKMRequest.h"
#import "VKSdk.h"

@implementation VKMRequest

+ (void)sendAudioSearchRequestForKey:(NSString *)query
                          offset:(NSString *)offset
                            count:(NSString *)count
                       auto_complete:(NSString *)auto_complete
                              lyrics:(NSString *)lyrics
                      performer_only:(NSString *)performer_only
                                sort:(NSString *)sort
                          search_own:(NSString *)search_own
                          completion:(void (^) (id))completion
                               error:(void (^) (void))error
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:query forKey:@"q"];
    [params setObject:auto_complete forKey:@"auto_complete"];
    [params setObject:lyrics forKey:@"lyrics"];
    [params setObject:performer_only forKey:@"performer_only"];
    [params setObject:sort forKey:@"sort"];//2:popular; 1:duration; 0:date
    [params setObject:search_own forKey:@"search_own"];
    [params setObject:offset forKey:@"offset"];
    [params setObject:count forKey:@"count"];//max = 300
    
    VKRequest *searchRequest = [VKApi requestWithMethod:@"audio.search" andParameters:params andHttpMethod:@"GET"];
    [searchRequest executeWithResultBlock:^(VKResponse *response)
     {
         completion(response.json);
     }
                               errorBlock:^(NSError *error)
     {
         if (error.code != VK_API_ERROR)
         {
             [error.vkError.request repeat];
         }
         else
         {
             NSLog(@"VK error: %@", error);
         }
     }];
    if (error)
    {
        error();
    }
}

+ (void)sendAudioSearchRequestForKey:(NSString *)query completion:(void (^) (id))completion error:(void (^) (void))error
{
    [self sendAudioSearchRequestForKey:query
                                offset:@"0"
                                 count:@"30"
                         auto_complete:@"1"
                                lyrics:@"0"
                        performer_only:@"0"
                                  sort:@"2"
                            search_own:@"0"
                            completion:completion
                                 error:error];
}

@end
