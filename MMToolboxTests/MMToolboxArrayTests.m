//
//  MMToolboxArrayTests.m
//  MMToolboxArrayTests
//
//  Created by Adam Wulf on 1/19/20.
//  Copyright © 2020 Milestone Made. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MMToolbox/MMToolbox.h>


@interface MMToolboxArrayTests : XCTestCase

@end


@implementation MMToolboxArrayTests

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

- (void)testBinarySearch11
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(3.5) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch12
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch13
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(9) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch14
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch15
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 4);
}

- (void)testBinarySearch16
{
    NSArray<NSNumber *> *nums = @[@1];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(2) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 1);
}

- (void)testBinarySearch17
{
    NSArray<NSNumber *> *nums = @[@1];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch18
{
    NSArray<NSNumber *> *nums = @[@1];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch19
{
    NSArray<NSNumber *> *nums = @[];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch20
{
    NSArray<NSNumber *> *nums = @[];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch21
{
    NSArray<NSNumber *> *nums = @[];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch22
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(5.5) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 12);
}

- (void)testBinarySearch23
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(5.5) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 12);
}

- (void)testBinarySearch24
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(4) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 9);
}

- (void)testBinarySearch25
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(7) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    // correct insertion index for missing item
    XCTAssertEqual(idx, 13);
}

- (void)testBinarySearch26
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(9) compare:obj];
    } options:NSBinarySearchingInsertionIndex];

    XCTAssertEqual(idx, 14);
}

- (void)testBinarySearch27
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(3.5) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch28
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(0) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch29
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(8.5) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, NSNotFound);
}

- (void)testBinarySearch30
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingFirstEqual];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch31
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @5, @6, @8, @9];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 4);
}

- (void)testBinarySearch32
{
    NSArray<NSNumber *> *nums = @[@1];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(1) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 0);
}

- (void)testBinarySearch33
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(8) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, 16);
}

- (void)testBinarySearch34
{
    NSArray<NSNumber *> *nums = @[@1, @1, @1, @1, @1, @2, @2, @3, @4, @4, @4, @4, @4, @4, @5, @6, @8];
    NSInteger idx = [nums indexPassingTest:^NSComparisonResult(NSNumber *obj, NSInteger index) {
        return [@(9) compare:obj];
    } options:NSBinarySearchingLastEqual];

    XCTAssertEqual(idx, NSNotFound);
}

@end
