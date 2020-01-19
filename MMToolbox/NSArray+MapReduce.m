//
//  NSArray+MapReduce.m
//  Loose Leaf
//
//  Created by Adam Wulf on 6/18/12.
//  Copyright (c) 2012 Milestone Made, LLC. All rights reserved.
//

#import "NSArray+MapReduce.h"
#import "Constants.h"


@implementation NSArray (MapReduce)

- (NSArray *)map:(id (^)(id obj, NSUInteger index))mapFunc
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSUInteger index;
    for (index = 0; index < [self count]; index++) {
        id foo = mapFunc([self objectAtIndex:index], index);
        if (foo) {
            [result addObject:foo];
        }
    }
    return result;
}

- (NSArray *)mapWithSelector:(SEL)mapSelector
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSUInteger index;
    for (index = 0; index < [self count]; index++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [result addObject:[[self objectAtIndex:index] performSelector:mapSelector]];
#pragma clang diagnostic pop
    }
    return result;
}

- (id)reduce:(id (^)(id obj, NSUInteger index, id accum))reduceFunc
{
    id result = NULL;
    NSUInteger index;
    for (index = 0; index < [self count]; index++) {
        result = reduceFunc([self objectAtIndex:index], index, result);
    }
    return result;
}

- (BOOL)reduceToBOOL:(BOOL (^)(id, NSUInteger, BOOL))reduceFunc
{
    BOOL result = NO;
    NSUInteger index;
    for (index = 0; index < [self count]; index++) {
        result = reduceFunc([self objectAtIndex:index], index, result);
    }
    return result;
}

- (id)choose:(BOOL (^)(id obj, NSUInteger index))chooseFunc
{
    id result = NULL;
    NSUInteger index;
    for (index = 0; index < [self count]; index++) {
        id obj = [self objectAtIndex:index];
        if (chooseFunc(obj, index)) {
            return obj;
        }
    }
    return result;
}

- (NSArray *)filter:(BOOL (^)(id obj, NSUInteger index))filterFunc
{
    NSMutableArray *ret = [NSMutableArray array];
    for (NSInteger index = 0; index < [self count]; index++) {
        id obj = [self objectAtIndex:index];
        if (filterFunc(obj, index)) {
            [ret addObject:obj];
        }
    }
    return ret;
}

- (BOOL)containsObjectIdenticalTo:(id)anObject
{
    return [self indexOfObjectIdenticalTo:anObject] != NSNotFound;
}

/// NSOrderedAscending the target index is before the given index
/// NSOrderedDescending the target index is after the given index
/// NSOrderedSame the input index is the target index
- (NSInteger)indexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator
{
    return [self indexPassingTest:enumerator options:NSBinarySearchingInsertionIndex];
}

/// NSBinarySearchingFirstEqual will find the earliest index that returns NSOrderedSame
/// NSBinarySearchingLastEqual will find the latest index that returns NSOrderedSame
/// NSBinarySearchingInsertionIndex will return the first index that returns NSOrderedSame
- (NSInteger)indexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator options:(NSBinarySearchingOptions)options
{
    return [self _indexPassingTest:enumerator inRange:NSMakeRange(0, [self count]) options:options];
}

- (NSInteger)_indexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator inRange:(NSRange)range options:(NSBinarySearchingOptions)options
{
    if (range.length == 1) {
        return range.location;
    }

    NSInteger testIndex = NSMidRange(range);
    NSComparisonResult result = enumerator([self objectAtIndex:testIndex], testIndex);

    if (result == NSOrderedAscending || (result == NSOrderedSame && options == NSBinarySearchingFirstEqual)) {
        return [self _indexPassingTest:enumerator inRange:NSMakeRange(range.location, testIndex - range.location) options:options];
    } else if (result == NSOrderedDescending) {
        return [self _indexPassingTest:enumerator inRange:NSMakeRange(testIndex + 1, range.length - (testIndex - range.location) - 1) options:options];
    } else if (result == NSOrderedSame && options == NSBinarySearchingLastEqual) {
        return [self _indexPassingTest:enumerator inRange:NSMakeRange(testIndex, range.length - (testIndex - range.location)) options:options];
    } else {
        return testIndex; // NSOrderedSame
    }
}

@end
