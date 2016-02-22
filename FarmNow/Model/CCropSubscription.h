//
//  CCropSubscription.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CCrop.h"

@protocol CCropSubscription
@end

@interface CCropSubscription : CJSONModel
@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) CCrop *crop;
@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSDictionary<Optional> *fields;
@end
