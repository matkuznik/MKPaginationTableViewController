//
//  MKPaginationTableViewController.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import "MKPaginationTableViewController.h"
@interface MKPaginationTableViewController()

@property(nonatomic,strong) MKPaginationTableViewModel *viewModel;

@end

@implementation MKPaginationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel: nil];
}

- (void)setupViewModel:(MKPaginationTableViewModel *)viewModel {
    if(!viewModel) {
        viewModel = [[MKPaginationTableViewModel alloc] init];
    }
    _viewModel = viewModel;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewItems) name:@"NewItems" object:nil];
    [self.viewModel loadMoreItems];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.viewModel invalidateTimer];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNewItems {
    if(self.viewModel.addedIndexPaths.count) {
        [self.tableView insertRowsAtIndexPaths:self.viewModel.addedIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.visibleItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReusableId" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Some random number";
    cell.detailTextLabel.text = self.viewModel.visibleItems[indexPath.row];
    
    if([self.viewModel.visibleItems count]-1 == indexPath.row) {
        [self.viewModel loadMoreItems];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Loading new items ...";
}
@end
