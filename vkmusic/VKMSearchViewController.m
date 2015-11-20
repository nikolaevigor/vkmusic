//
//  VKMSearchViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMSearchViewController.h"

@interface VKMSearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VKMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    cell.textLabel.text = @"Song name";
    return cell;
}



- (IBAction)searchTextFieldValueChanged:(id)sender {
    NSLog(@"Value changed for searchBox");
}
@end
