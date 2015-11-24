//
//  VKManager.m
//  vkmusic
//
//  Created by Igor Nikolaev on 24/11/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKManager.h"

@implementation VKManager

+ (NSMutableArray *)getTitlesForSearchQuery:(NSString *)query
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:query forKey:@"q"];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    VKRequest *searchRequest = [VKApi requestWithMethod:@"audio.search" andParameters:params andHttpMethod:@"GET"];
    searchRequest.waitUntilDone = YES;
    [searchRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = [response.json objectForKey:@"items"];
        for (int i=0; i<[items count]; i++)
        {
            [titles addObject:[items[i] objectForKey:@"title"]];
        }
    } errorBlock:^(NSError *error){
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        }
        else {
            NSLog(@"VK error: %@", error);
        }
    }];
    return titles;
}

@end
