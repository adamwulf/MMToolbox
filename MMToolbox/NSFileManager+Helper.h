//
//  NSFileManager+Helper.h
//  infinite-draw
//
//  Created by Adam Wulf on 10/15/19.
//  Copyright © 2019 Milestone Made. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSFileManager (Helper)

+ (NSString *)cachesPath;

+ (NSString *)documentsPath;

+ (NSURL *)documentsURL;

+ (void)ensureDirectoryExistsAtPath:(NSString *)path;

- (void)enumerateDirectory:(NSString *)directory withBlock:(void (^)(NSURL *item, NSUInteger totalItemCount))perItemBlock andErrorHandler:(BOOL (^__nullable)(NSURL *url, NSError *error))handler;

- (BOOL)isDirectory:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
