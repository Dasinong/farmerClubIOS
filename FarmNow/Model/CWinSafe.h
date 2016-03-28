//
//  CWinSafe.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CWinSafe
@end

@interface CWinSafe : CJSONModel
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *volume;
@property (nonatomic, assign) NSInteger count;
@end
