//
//  VKMAudioDownloader.m
//  vkmusic
//
//  Created by Igor Nikolaev on 15/02/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioDownloader.h"
#import "AFNetworking.h"

@implementation VKMAudioDownloader

+ (void)downloadSong:(NSString *)songURL
               store:(NSString *)path
            progress:(void (^) (double))progress
          completion:(void (^) (BOOL))completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0;
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:songURL]]
                                                             progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     progress(downloadProgress.fractionCompleted);
                                                                 });
                                                             } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                 return [NSURL fileURLWithPath:path];
                                                             } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                 if (!error) {
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
