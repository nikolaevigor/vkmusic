//
//  SongsTableViewCell.h
//  vkmusic
//
//  Created by Igor Nikolaev on 01/01/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
