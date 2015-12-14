//
//  CInsertSubScribeListModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSubscriptionObject.h"

@interface CInsertSubScribeListParams : CRequestBaseParams
@property (strong, nonatomic) NSNumber* id;//subscripiton的Id

@property (strong, nonatomic) NSString* targetName;		//收信人的姓名
@property (strong, nonatomic) NSString* cellphone;		//收信人的手机
@property (strong, nonatomic) NSString* province;		//收信人的地址(省)
@property (strong, nonatomic) NSString* city;			//收信人的地址(城市)
@property (strong, nonatomic) NSString* country;		//收信人的地址(村镇)
@property (strong, nonatomic) NSString* district;		//收信人的地址(地区)
@property (assign, nonatomic) double area;				//农田的大小
@property (assign, nonatomic) NSInteger cropId;			//作物Id
@property (strong, nonatomic) NSString* cropName;		//作物名称
@property (assign, nonatomic) BOOL isAgriWeather;		//是否订阅了天气服务
@property (assign, nonatomic) BOOL isNatAlter;			//是否订阅了气象预警服务
@property (assign, nonatomic) BOOL isRiceHelper;		//是否订阅了水稻服务
@end

@interface CInsertSubScribeListModel : CResponseModel
@property (strong, nonatomic) CSubscriptionObject<Optional>* data;
@end
