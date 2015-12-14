//
//  NSString+MD5HexDigest.h
//  VIVA
//
//  Created by liangzhe on 13-5-13.
//
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)
-(NSString *) md5HexDigest;
@end

@interface NSData (md5)
-(NSString *) md5HexDigest;
@end