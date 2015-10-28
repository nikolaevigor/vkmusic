//
//  VKMDownloadViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMDownloadViewController.h"

@interface VKMDownloadViewController ()

@end

@implementation VKMDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = @"1";
    NSLog(@"asdasdsad");
    return cell;
}

@end
