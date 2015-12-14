//
//  CGetSubScribeListsModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSubscriptionObject.h"

@interface CGetSubScribeListsParams : CRequestBaseParams

@end

@interface CGetSubScribeListsModel : CResponseModel
@property (strong, nonatomic) NSDictionary* data;
@end
