//
//  NSArray+MapReduce.m
//  Loose Leaf
//
//  Created by Adam Wulf on 6/18/12.
//  Copyright (c) 2012 Milestone Made, LLC. All rights reserved.
//

#import "NSArray+MapReduce.h"


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

- (BOOL)containsObjectIdenticalTo:(id)anObject
{
    return [self indexOfObjectIdenticalTo:anObject] != NSNotFound;
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

@end
