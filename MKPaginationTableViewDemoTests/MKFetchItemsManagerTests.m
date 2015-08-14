//
//  MKFetchItemsManagerTests.m
//  MKPaginationTableViewDemo
//
//  Created by Mateusz Kuźnik on 12/08/15.
//  Copyright (c) 2015 Mateusz Kuznik. All rights reserved.
//

#import "MKFetchItemsManager.h"
#import "MKSchedulerFactory.h"

@interface MKFetchItemsManager (UnitTests)
- (void)setSchedulerFactory:(MKSchedulerFactory *)schedulerFactory;
@end

@interface MKFetchItemsManagerTests : XCTestCase
@end

@implementation MKFetchItemsManagerTests {
    MKFetchItemsManager *sut;
    MKSchedulerFactory *schedulerFactoryMock;
}

- (void)setUp {
    [super setUp];
    sut = [[MKFetchItemsManager alloc] init];
    schedulerFactoryMock = [[MKSchedulerFactory alloc] init];
    [sut setSchedulerFactory:schedulerFactoryMock];
}

- (void)tearDown {
    sut = nil;
    schedulerFactoryMock = nil;
    [super tearDown];
}

- (void)testThatFetchItemsWillReturnSignal {
    [given([schedulerFactoryMock fetchScheduler]) willReturn:([RACScheduler mainThreadScheduler])];
    RACSignal *racSignal = [sut fetchItems];
    assertThat(racSignal, notNilValue());
    __block NSArray *items;
    [racSignal subscribeNext:^(id x) {
        items = x;
    }];

    expect(items).after(2.2).notTo.beNil();
    expect(items).after(2.2).to.haveCountOf(10);
}

@end
