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

+ (void)getTitlesForSearchQuery:(NSString *)query completion:(void (^) (NSMutableArray *))completion
{
    NSMutableArray *tracks = [[NSMutableArray alloc] init];
    
    [VKMRequest sendAudioSearchRequestForKey:query completion:^void (id json)
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

@end
