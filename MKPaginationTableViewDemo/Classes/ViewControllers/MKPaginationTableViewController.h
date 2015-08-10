//
//  MKPaginationTableViewController.h
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKPaginationTableViewModel.h"

@interface MKPaginationTableViewController : UITableViewController

- (void)setupViewModel:(MKPaginationTableViewModel *)viewModel;

@end
