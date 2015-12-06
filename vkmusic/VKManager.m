//
//  VKManager.m
//  vkmusic
//
//  Created by Igor Nikolaev on 24/11/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKManager.h"

@implementation VKManager

+ (void)getTitlesForSearchQuery:(NSString *)query completion:(void (^) (NSMutableArray *))completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:query forKey:@"q"];
    
    NSMutableArray *tracks = [[NSMutableArray alloc] init];
    
    VKRequest *searchRequest = [VKApi requestWithMethod:@"audio.search" andParameters:params andHttpMethod:@"GET"];
    [searchRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = [response.json objectForKey:@"items"];
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
    } errorBlock:^(NSError *error){
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        }
        else {
            NSLog(@"VK error: %@", error);
        }
    }];
}

@end
