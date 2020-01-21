//
//  NSArray+Extras.h
//  LooseLeaf
//
//  Created by Adam Wulf on 8/26/13.
//  Copyright (c) 2013 Milestone Made, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray <T> (Extras)

- (NSArray<T> *)reversedArray;

- (NSArray<T> *)arrayByRemovingFirstObject;

- (NSArray<T> *)arrayByRemovingObject:(T)obj;

- (NSArray<T> *)arrayByRemovingObjectsInArray:(NSArray<T> *)arr;

- (NSArray<T> *)shuffledArray;

- (NSSet<T> *)asSet;

- (BOOL)containsObjectIdenticalTo:(T)anObject;

// the returned NSComparisonResult should treat the input obj as the right hand argument of compare:
// so for an array of numbers, the enumerator could be [@targetNum compare:obj];
- (NSInteger)sortedIndexPassingTest:(NSComparisonResult (^)(T obj, NSInteger index))enumerator;

- (NSInteger)sortedIndexPassingTest:(NSComparisonResult (^)(T obj, NSInteger index))enumerator options:(NSBinarySearchingOptions)options;

@end


@interface NSMutableArray (Extras)

- (void)shuffle;

@end
