//
//  NSArray+MapReduce.h
//  Loose Leaf
//
//  Created by Adam Wulf on 6/18/12.
//  Copyright (c) 2012 Milestone Made, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray <T> (MapReduce)

- (NSArray *)map : (id (^)(T obj, NSUInteger index))mapFunc;

- (NSArray *)mapWithSelector:(SEL)mapSelector;

- (id)reduce:(id (^)(T obj, NSUInteger index, id accum))reduceFunc;

- (id)reduce:(id (^)(T obj, NSUInteger index, id accum))reduceFunc initially:(id)accum;

- (BOOL)reduceToBOOL:(BOOL (^)(T obj, NSUInteger index, BOOL accum))reduceFunc;

- (T)choose:(BOOL (^)(T obj, NSUInteger index))reducefunc;

- (NSArray<T> *)filter:(BOOL (^)(T obj, NSUInteger index))filterFunc;

@end
