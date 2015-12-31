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
                                                                     [self saveNode:node toEntity:@"Track"];
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

+ (void)saveNode:(VKMAudioNode *)node toEntity:(NSString *)entityName
{
    NSManagedObjectContext *mainContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSManagedObject *track = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:mainContext];
    [track setValue:[node name] forKey:@"name"];
    [track setValue:[node artist] forKey:@"artist"];
    [track setValue:[NSNumber numberWithDouble:[node duration]] forKey:@"duration"];
    [track setValue:[node url] forKey:@"url"];
    [track setValue:[node path] forKey:@"path"];
    [track setValue:[NSNumber numberWithBool:[node isDownloaded]] forKey:@"isDownloaded"];
    
    [mainContext save:nil];
}

@end