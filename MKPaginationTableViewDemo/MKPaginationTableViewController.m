//
//  MKPaginationTableViewController.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import "MKPaginationTableViewController.h"

@interface MKPaginationTableViewController()

@property (nonatomic, strong)NSArray *visibleItems;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation MKPaginationTableViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupData {
    self.visibleItems = [NSArray array];
    [self addTenItemsToArray];
}

- (void)addTenItemsToArray {
    NSMutableArray *newItems = [NSMutableArray array];
    NSMutableArray *newIndexPaths = [NSMutableArray array];
    NSInteger newFerstRow = [self.visibleItems count];
    for (NSInteger i = newFerstRow; i<newFerstRow + 10; i++) {
        [newItems addObject:[@(arc4random() % 1000) stringValue ]];
        [newIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    self.visibleItems = [[self.visibleItems mutableCopy] arrayByAddingObjectsFromArray:newItems];
    
    [self.tableView beginUpdates];
    if(newFerstRow > 0 ){
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: newFerstRow-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    self.timer = nil;
}

- (void)loadMoreItems {
    if(self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addTenItemsToArray) userInfo:nil repeats:NO];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.visibleItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReusableId" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Some random number";
    cell.detailTextLabel.text = self.visibleItems[indexPath.row];
    
    if([self.visibleItems count]-1 == indexPath.row) {
        [self loadMoreItems];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Loading new items ...";
}
@end
