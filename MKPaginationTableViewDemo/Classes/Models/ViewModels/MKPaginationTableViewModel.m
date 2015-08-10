//
//  MKPaginationTableViewModel.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/16/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKPaginationTableViewModel.h"

@interface MKPaginationTableViewModel ()

@property(nonatomic, strong, readwrite) NSArray *visibleItems;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation MKPaginationTableViewModel

- (instancetype)init {
    if ((self = [super init])) {
        [self setupData];
    }
    return self;
}

- (void)setupData {
    self.visibleItems = [NSArray array];
    [self addTenItemsToArray];
}

- (void)loadMoreItems {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addTenItemsToArray) userInfo:nil repeats:NO];
}

- (void)addTenItemsToArray {
    NSMutableArray *newItems = [NSMutableArray array];
    NSMutableArray *newIndexPaths = [NSMutableArray array];
    NSInteger newFirstRow = [self.visibleItems count];
    for (NSInteger i = newFirstRow; i < newFirstRow + 10; i++) {
        [newItems addObject:[@(arc4random() % 1000) stringValue]];
        [newIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    self.visibleItems = [[self.visibleItems mutableCopy] arrayByAddingObjectsFromArray:newItems];
    self.addedIndexPaths = newIndexPaths;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewItems" object:nil];
    [self invalidateTimer];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
