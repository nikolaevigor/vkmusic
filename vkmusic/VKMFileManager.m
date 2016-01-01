//
//  VKMFileManager.m
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMFileManager.h"

#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@implementation VKMFileManager

+ (void)saveNode:(VKMAudioNode *)node forEntity:(NSString *)entityName
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

+ (void)deleteNode:(VKMAudioNode *)node forEntity:(NSString *)entityName
{
    NSManagedObjectContext *mainContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSManagedObject *track = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:mainContext];
    [track setValue:[node name] forKey:@"name"];
    [track setValue:[node artist] forKey:@"artist"];
    [track setValue:[NSNumber numberWithDouble:[node duration]] forKey:@"duration"];
    [track setValue:[node url] forKey:@"url"];
    [track setValue:[node path] forKey:@"path"];
    [track setValue:[NSNumber numberWithBool:[node isDownloaded]] forKey:@"isDownloaded"];
    
    [mainContext deleteObject:track];
}

+ (NSArray *)loadTracksFromEntity:(NSString *)entityName
{
    NSManagedObjectContext *mainContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:mainContext];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [mainContext executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray *tracks = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *track in fetchedObjects) {
        NSString *name = [track valueForKey:@"name"];
        NSString *artist = [track valueForKey:@"artist"];
        NSString *url = [track valueForKey:@"url"];
        NSString *path = [track valueForKey:@"path"];
        NSTimeInterval duration = [[track valueForKey:@"duration"] doubleValue];
        BOOL isDownloaded = [[track valueForKey:@"isDownloaded"] boolValue];
        
        VKMAudioNode *node = [[VKMAudioNode alloc] initWithName:name type:@"mp3" size:2 artist:artist url:url duration:duration];
        [node setPath:path];
        [node setIsDownloaded:isDownloaded];
        
        [tracks addObject:node];
    }
    
    return tracks;
}

+ (void)deleteAllItemsForEntity:(NSString *)entityName
{
    NSManagedObjectContext *mainContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [mainContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [mainContext deleteObject:object];
    }
    
    error = nil;
    [mainContext save:&error];
}

//delete tracks only; does not delete sqlite files
+ (void)deleteAllFilesForEntity:(NSString *)entityName
{
    NSArray *tracks = [self loadTracksFromEntity:entityName];
    for (VKMAudioNode *node in tracks)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[node path] error: nil];
    }
    
}

// delete all files
+ (void)emptyDocumentsFolder
{
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
}

@end
