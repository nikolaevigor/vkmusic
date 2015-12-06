//
//  VKMAudioNode.h
//  vkmusic
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMMediaNode.h"

@interface VKMAudioNode : VKMMediaNode

// Artist's name. Can not be nil.
@property(nonatomic, nonnull) NSString *artist;
// Audio url in vk database.
@property(readonly, nonatomic, nonnull) NSString *url;
// Duration of the audio. Can not be 0.
@property (nonatomic) NSTimeInterval duration;
//
@property (nonatomic) BOOL isDownloaded;
// Path in file system. May be nil if node is not downloaded.
@property (nonatomic, nullable) NSString *path;

//@brief designated initializer
- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                type:(nonnull NSString *)type
                                size:(NSUInteger)size
                              artist:(nonnull NSString *)artist
                                 url:(nonnull NSString *)url
                            duration:(NSTimeInterval) duration;

// Prohibited
- (nonnull instancetype) initWithName:(nonnull NSString *)name type:(nonnull NSString *)type size:(NSUInteger)size __unavailable;

@end
