//
//  CLoadSubScribeListModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSubscriptionObject.h"

@interface CLoadSubScribeListParams : CRequestBaseParams

@property (assign, nonatomic) NSInteger id;			//subscription的Id

@end

@interface CLoadSubScribeListModel : CResponseModel
@property (strong, nonatomic) CSubscriptionObject* data;
@end
