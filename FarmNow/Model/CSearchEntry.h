//
//  CSearchEntry.h
//  FarmNow
//
//  Created by zheliang on 15/10/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CSearchEntry 

@end

@interface CSearchEntry : CJSONModel
@property (assign, nonatomic) NSInteger  id;//可以是品种id,农药id或者病虫草害id,由type来决定是哪种
@property (strong, nonatomic) NSString   * name;//可以是品种名字,农药名字或者病虫草害名字,由type决定是哪种
@property (strong, nonatomic) NSString   * source;//用来显示在客户端上subtitle的位置
@property (strong, nonatomic) NSString   * type;//是的,很confusing,和输入的type又不一样了
@end
