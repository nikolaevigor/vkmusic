//
//  playerDelegate.h
//  vkmusic
//
//  Created by Igor Nikolaev on 13/12/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

@protocol playerDelegate <NSObject>

@required

- (void)play;
- (void)stop;
- (void)pause;

@end
