//
//  NSArray+Extras.m
//  LooseLeaf
//
//  Created by Adam Wulf on 8/26/13.
//  Copyright (c) 2013 Milestone Made, LLC. All rights reserved.
//

#import "NSArray+Extras.h"
#import "Constants.h"


@implementation NSArray (Extras)

- (NSArray *)reversedArray
{
    NSMutableArray *outArray = [NSMutableArray array];
    for (id obj in self.reverseObjectEnumerator) {
        [outArray addObject:obj];
    }
    return [NSArray arrayWithArray:outArray];
}

- (NSArray *)arrayByRemovingFirstObject
{
    NSMutableArray *ret = [NSMutableArray arrayWithArray:self];
    if ([ret count]) {
        [ret removeObjectAtIndex:0];
    }
    return ret;
}


- (NSArray *)arrayByRemovingObject:(id)obj
{
    NSMutableArray *ret = [NSMutableArray arrayWithArray:self];
    [ret removeObject:obj];
    return ret;
}

- (NSArray *)arrayByRemovingObjectsInArray:(NSArray *)arr
{
    NSMutableArray *ret = [NSMutableArray arrayWithArray:self];
    for (NSObject *obj in arr) {
        [ret removeObject:obj];
    }
    return ret;
}

- (NSArray *)shuffledArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self];
    for (NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((unsigned int)i);
        [temp exchangeObjectAtIndex:i - 1 withObjectAtIndex:j];
    }
    return [NSArray arrayWithArray:temp];
}

- (NSSet *)asSet
{
    return [NSSet setWithArray:self];
}

- (BOOL)containsObjectIdenticalTo:(id)anObject
{
    return [self indexOfObjectIdenticalTo:anObject] != NSNotFound;
}

- (id)sortedObjectPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator
{
    NSInteger index = [self sortedIndexPassingTest:enumerator options:NSBinarySearchingFirstEqual];

    if (index != NSNotFound) {
        return [self objectAtIndex:index];
    }

    return nil;
}

/// NSOrderedAscending the target index is before the given index
/// NSOrderedDescending the target index is after the given index
/// NSOrderedSame the input index is the target index
- (NSInteger)sortedIndexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator
{
    return [self sortedIndexPassingTest:enumerator options:NSBinarySearchingInsertionIndex];
}

/// NSBinarySearchingFirstEqual will find the earliest index that returns NSOrderedSame
/// NSBinarySearchingLastEqual will find the latest index that returns NSOrderedSame
/// NSBinarySearchingInsertionIndex will return the first index that returns NSOrderedSame
- (NSInteger)sortedIndexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator options:(NSBinarySearchingOptions)options
{
    return [self _indexPassingTest:enumerator inRange:NSMakeRange(0, [self count]) options:options];
}

- (NSInteger)_indexPassingTest:(NSComparisonResult (^)(id obj, NSInteger index))enumerator inRange:(NSRange)range options:(NSBinarySearchingOptions)options
{
    if (range.length == 0) {
        if (options == NSBinarySearchingInsertionIndex) {
            // if we're searching from where to insert, then we're there when we end
            return range.location;
        } else {
            // otherwise, we haven't found what we're looking for. our of the recursive calls
            // might be able to return an index
            return NSNotFound;
        }
    }

    NSInteger testIndex = NSMidRange(range);
    NSComparisonResult result = enumerator([self objectAtIndex:testIndex], testIndex);

    if (result == NSOrderedAscending) {
        // the result is somewhere to our left, so clip off the last half of the range including our current index
        return [self _indexPassingTest:enumerator inRange:NSMakeRange(range.location, testIndex - range.location) options:options];
    } else if (result == NSOrderedDescending) {
        // the result is somewhere to our right, so clip off the first half of the range including our current index
        return [self _indexPassingTest:enumerator inRange:NSMakeRange(testIndex + 1, range.length - (testIndex - range.location) - 1) options:options];
    } else if (result == NSOrderedSame) {
        if (options == NSBinarySearchingFirstEqual) {
            // we found a match, check to see if we have a better match to our left and return that if so,
            // otherwise return our match
            NSInteger index = [self _indexPassingTest:enumerator inRange:NSMakeRange(range.location, testIndex - range.location) options:options];

            return index == NSNotFound ? testIndex : index;
        } else if (options == NSBinarySearchingLastEqual) {
            // we found a match, check if we have a better match to our right and return that if so,
            // otherwise return our match
            NSInteger index = [self _indexPassingTest:enumerator inRange:NSMakeRange(testIndex + 1, range.length - (testIndex - range.location) - 1) options:options];

            return index == NSNotFound ? testIndex : index;
        } else {
            // we found an equal index and only need to insert, so immediately return this index
            return testIndex;
        }
    }

    return NSNotFound;
}

@end


@implementation NSMutableArray (Extras)

- (void)shuffle
{
    for (NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((unsigned int)i);
        [self exchangeObjectAtIndex:i - 1 withObjectAtIndex:j];
    }
}

@end
