//
//  PaginationTableViewModel.h
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/16/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPaginationTableViewModel : NSObject

@property (nonatomic, strong, readonly)NSArray *visibleItems;
@property (nonatomic, strong) NSArray *addedIndexPaths;

- (void)loadMoreItems;

- (void)invalidateTimer;

@end
