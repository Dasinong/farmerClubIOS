//
//  CSortItemByFirstLetter.m
//  QQStock
//
//  Created by yinzezhang on 15/7/13.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "CSortItemByFirstLetter.h"
//#import "NSString+operateString.h"


@interface CSortItemByFirstLetter ()

@property(nonatomic,readwrite,strong)NSMutableArray* keys;
@property(nonatomic,readwrite,strong)NSMutableDictionary* itemsBySort;
@property(nonatomic,strong)NSArray* items;

@end


@implementation CSortItemByFirstLetter

-(instancetype)initWithItems:(NSArray *)items{
    if (self = [super init]) {
        self.items = items;
        self.itemsBySort = [NSMutableDictionary dictionaryWithCapacity:1];
        self.keys = [NSMutableArray arrayWithCapacity:1];
        [self sortAndGroupFriends];
    }
    return self;
}


-(void)sortAndGroupFriends{
    //排序
    
    NSArray *sortArray = [self.items sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        id<CSortItemByFirstLetterProtocol> one = (id<CSortItemByFirstLetterProtocol>)obj1;
        id<CSortItemByFirstLetterProtocol> two = (id<CSortItemByFirstLetterProtocol>)obj2;
        
        if (!(one && two)) return NSOrderedSame;
        
        NSString* titleOne = [NSString subFirstLetter:[one getSortString]];
        NSString* titleTwo = [NSString subFirstLetter:[one getSortString]];
        
        NSComparisonResult result = [titleOne compare:titleTwo];
        return result;
    }];
    
    //分组
    __block CSortItemByFirstLetter* weakSelf = self;
    
    [sortArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<CSortItemByFirstLetterProtocol> user = (id<CSortItemByFirstLetterProtocol>)obj;
        if (user && [user conformsToProtocol:@protocol(CSortItemByFirstLetterProtocol)]) {
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:1];
            
            NSString* key = [NSString subFirstLetter:[user getSortString]];
            
            if ([[weakSelf.itemsBySort allKeys] containsObject:key]) {
                [[weakSelf.itemsBySort objectForKey:key] addObject:user];
            }else{
                [array addObject:user];
                [(NSMutableDictionary*)weakSelf.itemsBySort setObject:array forKey:key];
            }
        }
    }];
    
    self.items = sortArray;
    
    for(NSString* key in [self.itemsBySort allKeys]) {
        NSArray* arry = [self.itemsBySort objectForKey:key];
        arry = [arry sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            id<CSortItemByFirstLetterProtocol> one = (id<CSortItemByFirstLetterProtocol>)obj1;
            id<CSortItemByFirstLetterProtocol> two = (id<CSortItemByFirstLetterProtocol>)obj2;
            NSComparisonResult result = [[one getSortString] localizedStandardCompare:[two getSortString]];
            return result;
        }];
        [(NSMutableDictionary*)self.itemsBySort setObject:arry forKey:key];
        
    }
    
    //关键字排序
    self.keys = [[self.itemsBySort allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* str1 = (NSString*)obj1;
        NSString* str2 = (NSString*)obj2;
        if([str1 isEqualToString: @"#"])
            return NSOrderedDescending;
        if ([str2 isEqualToString:@"#"])
            return NSOrderedAscending;
        return [str1 compare:str2];
    }] ;
}


@end
