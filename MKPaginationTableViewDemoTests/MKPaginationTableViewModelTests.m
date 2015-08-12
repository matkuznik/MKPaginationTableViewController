//
//  MKPaginationTableViewDemoTests.m
//  MKPaginationTableViewDemoTests
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import "MKPaginationTableViewModel.h"
#import "MKFetchItemsManager.h"

@interface MKPaginationTableViewModelTests : XCTestCase

@end

@implementation MKPaginationTableViewModelTests {
    MKPaginationTableViewModel *sut;
    MKFetchItemsManager *fetchItemsManagerMock;
}

- (void)setUp {
    [super setUp];
    fetchItemsManagerMock = mock([MKFetchItemsManager class]);
    sut = [[MKPaginationTableViewModel alloc] init];
    [sut performSelector:@selector(setFetchItemsManager:) withObject:fetchItemsManagerMock];
}

- (void)tearDown {
    [super tearDown];
    sut = nil;
}

- (void)testThatLoadMoreItemsWillUpdateDataSource {
    [given([fetchItemsManagerMock fetchItems]) willReturn:[RACSignal return:@[@"1", @"2", @"3", @"4"]]];
    assertThatInteger([sut numberOfRowsInSection:0], is(equalToInteger(0)));
    [sut loadMoreItems];
    assertThatInteger([sut numberOfRowsInSection:0], is(equalToInteger(4)));
}

- (void)testThatTextAtIndexPathWillReturnValidText {
    [given([fetchItemsManagerMock fetchItems]) willReturn:[RACSignal return:@[@"1", @"2", @"3", @"4"]]];
    assertThatInteger([sut numberOfRowsInSection:0], is(equalToInteger(0)));
    [sut loadMoreItems];
    assertThat([sut textForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]], is(equalTo(@"3")));
}
@end
