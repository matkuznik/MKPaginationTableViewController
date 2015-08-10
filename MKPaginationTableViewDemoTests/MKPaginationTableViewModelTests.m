//
//  MKPaginationTableViewDemoTests.m
//  MKPaginationTableViewDemoTests
//
//  Created by Mateusz Kuznik on 12/4/14.
//  Copyright (c) 2014 Mateusz Kuznik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MKPaginationTableViewModel.h"

@interface MKPaginationTableViewModelTests : XCTestCase

@end

@implementation MKPaginationTableViewModelTests {
    MKPaginationTableViewModel *sut;
}

- (void)setUp {
    [super setUp];
    sut = [[MKPaginationTableViewModel alloc] init];
}

- (void)tearDown {
    [super tearDown];
    sut = nil;
}



@end
