//
//  VKMFileManager.h
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKMAudioNode.h"

@interface VKMFileManager : NSObject

+ (void)saveNode:(VKMAudioNode *)node forEntity:(NSString *)entityName;
+ (void)deleteNode:(VKMAudioNode *)node forEntity:(NSString *)entityName;
+ (NSArray *)loadTracksFromEntity:(NSString *)entityName;
+ (void)deleteFileForNode:(VKMAudioNode *)node;
+ (void)deleteAllItemsForEntity:(NSString *)entityName;
+ (void)deleteAllFilesForEntity:(NSString *)entityName;
+ (void)emptyDocumentsFolder;

@end