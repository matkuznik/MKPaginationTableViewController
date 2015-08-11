//
//  MKPaginationTableViewController.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import "MKPaginationTableViewController.h"

@interface MKPaginationTableViewController ()

@property(nonatomic, strong) MKPaginationTableViewModel *viewModel;

@end

@implementation MKPaginationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel:nil];
    [self setupObservers];
    [self.viewModel loadMoreItems];
}

- (void)setupViewModel:(MKPaginationTableViewModel *)viewModel {
    if (!viewModel) {
        viewModel = [[MKPaginationTableViewModel alloc] init];
    }
    _viewModel = viewModel;
}

- (void)setupObservers {
    @weakify(self)
    [[RACObserve(self.viewModel, indexPathsToAdd)
            deliverOn:[RACScheduler mainThreadScheduler]]
            subscribeNext:^(NSArray *indexPathsToAdd) {
                @strongify(self)
                if (indexPathsToAdd.count) {
                    [self.tableView insertRowsAtIndexPaths:indexPathsToAdd withRowAnimation:UITableViewRowAnimationBottom];
                    self.viewModel.indexPathsToAdd = nil;
                }
            }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReusableId" forIndexPath:indexPath];

    cell.textLabel.text = @"Some random number";
    cell.detailTextLabel.text = [self.viewModel textForRowAtIndexPath:indexPath];

    NSInteger numberOfItems = [self.viewModel numberOfRowsInSection:indexPath.section];
    if (numberOfItems == 0 || numberOfItems - 1 == indexPath.row) {
        [self.viewModel loadMoreItems];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Loading new items ...";
}
@end
