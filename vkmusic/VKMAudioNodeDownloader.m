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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 5.0;
    AFHTTPRequestOperation *operation = [manager GET:[node url]
                                   parameters:nil
                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                          NSLog(@"successful download to %@", path);
                                          [progressBar setHidden:YES];
                                          [progressBar setProgress:0];
                                          [node setIsDownloaded:YES];
                                          [node setPath:[path copy]];
                                          [self saveNode:node toEntity:@"Track"];
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