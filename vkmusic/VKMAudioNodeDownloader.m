//
//  VKMAudioNodeDownloader.m
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMAudioNodeDownloader.h"

@implementation VKMAudioNodeDownloader

+ (void)downloadNode:(VKMAudioNode *)node
               store:(NSString *)path
     withProgressBar:(UIProgressView *)progressBar
          completion:(void (^) (BOOL))completion
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        [node setIsDownloaded:YES];
        NSLog(@"Directory already exists!");
        return;
    };
    
    [progressBar setHidden:NO];
    [node setPath:[path copy]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 5.0;
    AFHTTPRequestOperation *operation = [manager GET:[node url]
                                   parameters:nil
                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                          NSLog(@"successful download to %@", path);
                                          [progressBar setHidden:YES];
                                          [progressBar setProgress:0];
                                          [node setIsDownloaded:YES];
                                          completion(YES);
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          NSLog(@"Error: %@", error);
                                          [progressBar setHidden:YES];
                                          [progressBar setProgress:0];
                                          completion(NO);
                                      }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) { float progress = totalBytesRead / (float)totalBytesExpectedToRead; progressBar.progress = progress;}];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
}

@end
