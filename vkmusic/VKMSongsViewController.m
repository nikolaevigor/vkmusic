//
//  VKMSearchViewController.m
//  vkmusic
//
//  Created by Igor Nikolaev on 29/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import "VKMSongsViewController.h"
#import "VKMFileManager.h"

@interface VKMSongsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tracks;

@end

@implementation VKMSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tracks = [VKMFileManager loadTracksFromEntity:@"Track"];
    [self.tableView reloadData];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *const CellID = @"ReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = [self.tracks[indexPath.row] name];
    return cell;
}

#pragma mark - Text Field Events methods

- (IBAction)searchBoxEditingDidBegin:(id)sender {
    self.searchTextField.text = @"";
}

- (IBAction)searchBoxEditingDidEnd:(id)sender {
    
}

#pragma mark - Text Field methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
