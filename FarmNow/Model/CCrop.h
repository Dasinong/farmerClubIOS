//
//  CCrop.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CCrop
@end

@interface CCrop : CJSONModel
@property (assign, nonatomic) NSInteger cropId;
@property (strong, nonatomic) NSString *cropName;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *iconUrl;
@end
