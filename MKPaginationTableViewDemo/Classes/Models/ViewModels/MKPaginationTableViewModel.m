//
//  MKPaginationTableViewModel.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/16/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import "MKPaginationTableViewModel.h"
#import "MKFetchItemsManager.h"

@interface MKPaginationTableViewModel ()

@property(nonatomic, strong) MKFetchItemsManager *fetchItemsManager;
@property(nonatomic, strong, readwrite) NSArray *visibleItems;

@property(nonatomic) BOOL isItemsLoading;
@end

@implementation MKPaginationTableViewModel

- (instancetype)init {
    if ((self = [super init])) {
        [self setupData];
    }
    return self;
}

- (void)setupData {
    self.fetchItemsManager = [[MKFetchItemsManager alloc] init];
    self.visibleItems = [NSArray array];
}

- (void)loadMoreItems {
    if (self.isItemsLoading) {
        return;
    }
    self.isItemsLoading = YES;
    @weakify(self)
    [[self.fetchItemsManager fetchItems]
            subscribeNext:^(NSArray *itemsToAdd) {
                @strongify(self)
                [self addItemsToDataSource:itemsToAdd];
                self.isItemsLoading = NO;
            }];
}

- (void)addItemsToDataSource:(NSArray *)items {
    if (items.count) {
        NSUInteger firstRowToAdd = self.visibleItems.count;
        self.visibleItems = [self.visibleItems arrayByAddingObjectsFromArray:items];
        NSUInteger lastRowToAdd = self.visibleItems.count - 1;
        NSMutableArray *indexToAdd = [NSMutableArray array];
        for (NSInteger index = firstRowToAdd; index <= lastRowToAdd; index++) {
            [indexToAdd addObject:[NSIndexPath indexPathForItem:index inSection:0]];
        }
        self.indexPathsToAdd = indexToAdd;
    }
}

#pragma mark - Data Source

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.visibleItems.count;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.visibleItems[(NSUInteger) indexPath.row];
}

@end
