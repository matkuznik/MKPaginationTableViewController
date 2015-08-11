//
//  PaginationTableViewModel.h
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/16/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPaginationTableViewModel : NSObject

@property(nonatomic, strong) NSArray *indexPathsToAdd;

- (void)loadMoreItems;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)path;

@end
