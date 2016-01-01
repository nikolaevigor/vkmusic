//
//  VKMAudioNodeDownloader.m
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioNodeDownloader.h"

#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#import "VKMFileManager.h"

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
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0;
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[node url]]]
                                                             progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     progress(downloadProgress.fractionCompleted);
                                                                 });
                                                             } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                 return [NSURL fileURLWithPath:path];
                                                             } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                 if (!error) {
                                                                     [node setIsDownloaded:YES];
                                                                     [node setPath:[path copy]];
                                                                     [VKMFileManager saveNode:node forEntity:@"Track"];
                                                                     completion(YES);
                                                                 }
                                                                 else
                                                                 {
                                                                     NSLog(@"Error: %@", error);
                                                                     completion(NO);
                                                                 }
                                                             }];
    
    [task resume];
}

@end