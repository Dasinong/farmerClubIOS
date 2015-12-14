//
//  NSString+Path.m
//  VIVA
//
//  Created by liangzhe on 13-8-1.
//
//

#import "NSString+Path.h"
#import "NSArray+Extra.h"

@implementation NSString (Path)

+ (NSString *)documentPath
{
    static dispatch_once_t once;
    static NSString *result = nil;

    dispatch_once(&once, ^{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            result = [paths at:0];
        });
    return result;
}

+ (NSString *)cachePath
{
    static dispatch_once_t once;
    static NSString *result = nil;

    dispatch_once(&once, ^{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            result = [paths at:0];
        });
    return result;
}

+ (NSString *)cachePathForResource:(NSString *)resource
{
    return [[self cachePath] stringByAppendingPathComponent:resource];
}

- (BOOL)exist
{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

- (NSString *)join:(NSString *)string
{
    return [self stringByAppendingString:string];
}

- (NSString *)joinPath:(NSString*)component
{
    return [self stringByAppendingPathComponent:component];
}

- (NSString *)joinExtension:(NSString *)externsion
{
    return [self stringByAppendingPathExtension:externsion];
}

- (NSString *)parent
{
    return [self stringByDeletingLastPathComponent];
}

- (void)mkdir_s
{
    if (![self exist])
    {
        [self mkdir];
    }
}

- (void)mkdir
{
    NSError *error = nil;

    [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:&error];
}

@end
