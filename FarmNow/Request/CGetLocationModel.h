//
//  CGetLocationModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/6.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CGetLocationParams : CRequestBaseParams
@property (strong, nonatomic) NSString* province;	//省
@property (strong, nonatomic) NSString* city;		//市
@property (strong, nonatomic) NSString* country;	//区
@property (strong, nonatomic) NSString* district;	//镇

@end

@interface CGetLocationModel : CResponseModel
@property (strong, nonatomic) NSDictionary* data;
@end
