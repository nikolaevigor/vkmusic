//
//  AppDelegate.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"
#import "playerDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, playerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

@end

