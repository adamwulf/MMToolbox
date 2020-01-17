//
//  NSFileManager+Helper.m
//  infinite-draw
//
//  Created by Adam Wulf on 10/15/19.
//  Copyright © 2019 Milestone Made. All rights reserved.
//

#import "NSFileManager+Helper.h"


@implementation NSFileManager (Helper)

static NSArray *userDocumentsPaths;

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

@end
