//
//  VKManager.m
//  vkmusic
//
//  Created by Igor Nikolaev on 24/11/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKManager.h"

#import "VKMAudioNode.h"
#import "VKMRequest.h"

@implementation VKManager

+ (void)getTitlesForSearchQuery:(NSString *)query
                         offset:(NSString *)offset
                          count:(NSString *)count
                  auto_complete:(NSString *)auto_complete
                         lyrics:(NSString *)lyrics
                 performer_only:(NSString *)performer_only
                           sort:(NSString *)sort
                     search_own:(NSString *)search_own
                     completion:(void (^)(NSMutableArray *))completion
{
    NSMutableArray *tracks = [[NSMutableArray alloc] init];
    
    [VKMRequest sendAudioSearchRequestForKey:query offset:offset count:count auto_complete:auto_complete lyrics:lyrics performer_only:performer_only sort:sort search_own:search_own completion:^void (id json)
     {
         NSArray *items = [json objectForKey:@"items"];
         for (id item in items)
         {
             @try {
                 __unused VKMAudioNode *node = [[VKMAudioNode alloc] initWithName:[item objectForKey:@"title"]
                                                                             type:@".mp3"
                                                                             size:2
                                                                           artist:[item objectForKey:@"artist"]
                                                                              url:[item objectForKey:@"url"]
                                                                         duration:[[item objectForKey:@"duration"] doubleValue]];
             }
             @catch (NSException *exception) {
                 continue;
             }
             
             VKMAudioNode *node = [[VKMAudioNode alloc] initWithName:[item objectForKey:@"title"]
                                                                type:@".mp3"
                                                                size:2
                                                              artist:[item objectForKey:@"artist"]
                                                                 url:[item objectForKey:@"url"]
                                                            duration:[[item objectForKey:@"duration"] doubleValue]];
             
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *path = [NSString stringWithFormat:@"%@/%@-%@", [paths objectAtIndex:0], [node artist], [node name]];
             NSFileManager *fileManager = [NSFileManager defaultManager];
             if ([fileManager fileExistsAtPath:path])
             {
                 [node setIsDownloaded:YES];
                 [node setPath:path];
             };
             
             [tracks addObject:node];
         }
         if (completion)
         {
             completion(tracks);
         }
     }
                                       error:nil];
}

+ (void)getTitlesForSearchQuery:(NSString *)query offset:(NSString *)offset count:(NSString *)count completion:(void (^)(NSMutableArray *))completion
{
    [self getTitlesForSearchQuery:query offset:offset count:count auto_complete:@"1" lyrics:@"0" performer_only:@"0" sort:@"2" search_own:@"0" completion:completion];
}

+ (void)getTitlesForSearchQuery:(NSString *)query completion:(void (^) (NSMutableArray *))completion
{
    [self getTitlesForSearchQuery:query offset:@"0" count:@"30" completion:completion];
}

@end
