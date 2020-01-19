//
//  MMToolboxTests.m
//  MMToolboxTests
//
//  Created by Adam Wulf on 1/19/20.
//  Copyright © 2020 Milestone Made. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MMToolbox/MMToolbox.h>


@interface MMToolboxTests : XCTestCase

@end


@implementation MMToolboxTests

- (void)testBinarySearch1
{
    NSArray<NSNumber *> *nums = @[@1, @3, @4, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    }];

    XCTAssertEqual(idx, 2);
}

- (void)testBinarySearch2
{
    NSArray<NSNumber *> *nums = @[@1, @3, @4];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    }];

    XCTAssertEqual(idx, 2);
}

- (void)testBinarySearch3
{
    NSArray<NSNumber *> *nums = @[@1, @3, @4, @4, @4, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    }];

    XCTAssertEqual(idx, 3);
}

- (void)testBinarySearch4
{
    NSArray<NSNumber *> *nums = @[@1, @3, @4, @4, @4, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, 2);
}

- (void)testBinarySearch5
{
    NSArray<NSNumber *> *nums = @[@1, @3, @4, @4, @4, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 4);
}

- (void)testBinarySearch6
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 13);
}

- (void)testBinarySearch7
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, 8);
}

- (void)testBinarySearch8
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 9);
}

- (void)testBinarySearch9
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(7) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    // correct insertion index for missing item
    XCTAssertEqual(idx, 13);
}

- (void)testBinarySearch10
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(9) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 14);
}

@end
