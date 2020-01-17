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

+ (NSString *)documentsPath;

+ (NSURL *)documentsURL;

+ (void)ensureDirectoryExistsAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
