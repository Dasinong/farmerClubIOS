//
//  CStore.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/15.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CStore
@end

@interface CStore : CJSONModel
@property (assign, nonatomic) NSInteger id; // "id": 15,
@property (nonatomic, strong) NSString *name; // "name": "河南郑州1",
@property (nonatomic, strong) NSString *desc; // "desc": "0号店",
@property (assign, nonatomic) NSInteger ownerId; // "ownerId": 1362,
@property (nonatomic, strong) NSString *contactName; // "contactName": "123",
@property (nonatomic, strong) NSString *location; // "location": "河南郑州荥阳市王村镇木楼村",
@property (nonatomic, strong) NSString *province; // "province": "郑州",
@property (nonatomic, strong) NSString *streetAndNumber; // "streetAndNumber": "123",
@property (nonatomic, strong) NSString *phone; // "phone": "123",
@property (nonatomic, strong) NSString *cellphone; // "cellphone": null,
@property (assign, nonatomic) NSInteger type;  // "type": 15,
@property (nonatomic, strong) NSString *status; // "status": "PENDING",
@property (nonatomic, strong) NSString *source; // "source": "REGISTRATION",
@property (assign, nonatomic) NSTimeInterval createdAt; // "createdAt": 1451459875000,
@property (assign, nonatomic) NSTimeInterval updatedAt; // "updatedAt": 1451459875000
@end
