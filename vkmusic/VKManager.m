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
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    VKRequest *searchRequest = [VKApi requestWithMethod:@"audio.search" andParameters:params andHttpMethod:@"GET"];
    [searchRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = [response.json objectForKey:@"items"];
        for (id item in items)
        {
            [titles addObject:[item objectForKey:@"title"]];
        }
        if (completion)
        {
            completion(titles);
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
