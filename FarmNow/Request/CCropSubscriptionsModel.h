//
//  CCropSubscriptionsModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCropSubscription.h"

@interface CCropSubscriptionsParam : CRequestBaseParams

@end

@interface CCropSubscriptionsModel : CResponseModel
@property (strong, nonatomic) NSArray<CCropSubscription, Optional>* subscriptions;
@end
