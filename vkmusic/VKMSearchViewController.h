//
//  VKMSearchViewController.h
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKMSearchViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)searchTextFieldValueChanged:(id)sender;

@end
