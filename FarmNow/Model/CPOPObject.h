//
//  CPOPObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CPOPObject
@end

@interface CPOPObject : CJSONModel
@property (assign, nonatomic) NSInteger morning;		//上午的降水概率(单位%)
@property (assign, nonatomic) NSInteger noon;			//中午的降水概率(单位%)
@property (assign, nonatomic) NSInteger night;			//晚上的降水概率(单位%)
@property (assign, nonatomic) NSInteger nextmidnight;	//半夜的降水概率(单位%)

@end
