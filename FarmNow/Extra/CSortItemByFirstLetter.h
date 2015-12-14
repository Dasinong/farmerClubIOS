//
//  CSortItemByFirstLetter.h
//  QQStock
//
//  Created by yinzezhang on 15/7/13.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSortItemByFirstLetterProtocol <NSObject>

- (NSString*)getSortString;

@end
@interface CSortItemByFirstLetter : NSObject

@property(nonatomic,readonly,strong)NSArray* keys;
@property(nonatomic,readonly,strong)NSDictionary* itemsBySort;


-(instancetype)initWithItems:(NSArray*)items;//<CUserData*>

@end
