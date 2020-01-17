//
//  NSFileManager+Helper.m
//  infinite-draw
//
//  Created by Adam Wulf on 10/15/19.
//  Copyright © 2019 Milestone Made. All rights reserved.
//

#import "NSFileManager+Helper.h"


@implementation NSFileManager (Helper)

static NSArray *userCachesPaths;
static NSArray *userDocumentsPaths;

+ (NSString *)cachesPath
{
    if (!userCachesPaths) {
        userCachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    }
    return [userCachesPaths objectAtIndex:0];
}

+ (NSString *)documentsPath
{
    if (!userDocumentsPaths) {
        userDocumentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    }
    return [userDocumentsPaths objectAtIndex:0];
}

+ (NSURL *)documentsURL
{
    NSString *docPath = [self documentsPath];

    return [NSURL fileURLWithPath:docPath];
}

+ (void)ensureDirectoryExistsAtPath:(NSString *)path
{
    if (!path) {
        return;
    }

    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)enumerateDirectory:(NSString *)directory withBlock:(void (^)(NSURL *item, NSUInteger totalItemCount))perItemBlock andErrorHandler:(BOOL (^)(NSURL *url, NSError *error))handler
{
    if (directory) {
        NSArray *directoryContents = [[self enumeratorAtURL:[NSURL fileURLWithPath:directory] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsPackageDescendants errorHandler:handler] allObjects];
        for (NSURL *subpath in directoryContents) {
            perItemBlock(subpath, [directoryContents count]);
        }
    }
}

- (BOOL)isDirectory:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL exists = path && [self fileExistsAtPath:path isDirectory:&isDirectory];
    return isDirectory && exists;
}

@end
