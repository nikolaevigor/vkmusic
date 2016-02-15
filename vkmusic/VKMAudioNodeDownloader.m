//
//  VKMAudioNodeDownloader.m
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioNodeDownloader.h"

#import "VKMFileManager.h"
#import "VKMAudioDownloader.h"

@implementation VKMAudioNodeDownloader

+ (void)downloadNode:(VKMAudioNode *)node
               store:(NSString *)path
            progress:(void (^) (double))progress
          completion:(void (^) (BOOL))completion
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        [node setIsDownloaded:YES];
        NSLog(@"Directory already exists!");
        return;
    };
    
    [VKMAudioDownloader downloadSong:[node url]
                               store:path
                            progress:progress
                          completion:^void (BOOL result)
     {
         [node setIsDownloaded:YES];
         [node setPath:[path copy]];
         [VKMFileManager saveNode:node forEntity:@"Track"];
         completion(result);
     }
     ];
}

@end