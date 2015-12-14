//
//  NSString+Path.h
//  VIVA
//
//  Created by liangzhe on 13-8-1.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

+ (NSString *)documentPath;
+ (NSString *)cachePath;
+ (NSString *)cachePathForResource:(NSString *)resource;

- (NSString *)join:(NSString *)path;
- (NSString *)joinExtension:(NSString*)pathExternsion;
- (NSString *)joinPath:(NSString *)pathComponent;

- (NSString *)parent;

/*
 * 判断对应的文件是否存在
 */
- (BOOL)exist;
- (void)mkdir_s;
- (void)mkdir;
@end
