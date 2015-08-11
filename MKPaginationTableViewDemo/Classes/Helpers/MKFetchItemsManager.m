//
// Created by Mateusz Kuźnik on 10/08/15.
// Copyright (c) 2015 Mateusz Kuznik. All rights reserved.
//

#import "MKFetchItemsManager.h"
#import "MKSchedulerFactory.h"

NSUInteger newItemsCount = 10;

@interface MKFetchItemsManager ()

@property(nonatomic, strong) MKSchedulerFactory *schedulerFactory;

@end

@implementation MKFetchItemsManager

- (instancetype)init {
    if (self = [super init]) {
        _schedulerFactory = [[MKSchedulerFactory alloc] init];
    }
    return self;
}

- (NSArray *)fetchItemsMock {
    NSMutableArray *newItems = [NSMutableArray array];
    for (NSInteger i = 0; i < newItemsCount; i++) {
        [newItems addObject:[@(arc4random() % 10000) stringValue]];
    }
    return newItems;
}

- (RACSignal *)fetchItems {
    return [[[RACSignal return:[self fetchItemsMock]] delay:5.f] subscribeOn:[self.schedulerFactory fetchScheduler]];
}

@end