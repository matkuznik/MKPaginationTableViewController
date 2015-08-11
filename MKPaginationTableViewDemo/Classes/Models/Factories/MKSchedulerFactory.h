//
// Created by Mateusz Kuźnik on 10/08/15.
// Copyright (c) 2015 Mateusz Kuznik. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MKSchedulerFactory : NSObject
- (RACScheduler *)fetchScheduler;
@end