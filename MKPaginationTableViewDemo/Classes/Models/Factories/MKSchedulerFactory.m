//
// Created by Mateusz Kuźnik on 10/08/15.
// Copyright (c) 2015 Mateusz Kuznik. All rights reserved.
//

#import "MKSchedulerFactory.h"

NSString *const fetchSchedulerName = @"com.kuznik.mateusz.scheduler.fetch";

@implementation MKSchedulerFactory

- (RACScheduler *)fetchScheduler {
    return [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground name:fetchSchedulerName];
}

@end