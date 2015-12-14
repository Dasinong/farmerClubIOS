//
//  CInstitutionEmployeeApplicationsModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CInstitutionEmployeeApplicationsParams : CRequestBaseParams

@property (strong, nonatomic) NSString* cellphone;
@property (strong, nonatomic) NSString* code;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* region;
@property (strong, nonatomic) NSString* contactName;

@end

@interface CInstitutionEmployeeApplicationsModel : CResponseModel

@end
