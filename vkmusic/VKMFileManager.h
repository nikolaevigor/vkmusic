//
//  VKMFileManager.h
//  vkmusic
//
//  Created by Igor Nikolaev on 06/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKMFileManager : NSObject

+ (NSArray *)loadTracksFromEntity:(NSString *)entityName;
+ (void)deleteAllEntities:(NSString *)entityName;
+ (void)emptyDocumentsFolder;

@end
