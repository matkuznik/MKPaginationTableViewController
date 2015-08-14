//
//  MKSchedulerFactoryTests.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuźnik on 12/08/15.
//  Copyright (c) 2015 Mateusz Kuznik. All rights reserved.
//

#import "MKSchedulerFactory.h"

@interface MKSchedulerFactoryTests : XCTestCase

@end

@implementation MKSchedulerFactoryTests {
    MKSchedulerFactory *sut;
}

- (void)setUp {
    [super setUp];
    sut = [[MKSchedulerFactory alloc] init];
}

- (void)tearDown {
    sut = nil;
    [super tearDown];
}

- (void)testThatFetchSchedulerMethodWillProduceValidScheduler {
    RACScheduler *scheduler = [sut fetchScheduler];
    assertThat(scheduler, notNilValue());
    assertThat([scheduler description], containsString(@"com.kuznik.mateusz.scheduler.fetch"));
}


@end
