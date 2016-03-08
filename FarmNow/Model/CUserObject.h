//
//  CUserObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/25.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol NSNumber

@end
@protocol CUserObject 
@end
@interface CUserObject : CJSONModel
@property (assign, nonatomic) NSInteger  userId;//用户Id
@property (strong, nonatomic) NSString<Optional>   * userName;//用户名
@property (strong, nonatomic) NSString<Optional>   * cellPhone;//手机号
@property (strong, nonatomic) NSString<Optional>   * address;//用户地址
@property (assign, nonatomic) BOOL       isPassSet;//是否设置过密码
@property (assign, nonatomic) BOOL       authenticated;//是否通过验证
@property (assign, nonatomic) NSInteger  memberPoints; // 积分

@property (strong, nonatomic) NSString<Optional>   * pictureId;//用户头像路径
@property (strong, nonatomic) NSString<Optional>   * institutionId;//代表机 构码对应的机构
@property (strong, nonatomic) NSString<Optional>   * userType;//用户头像路径

@property (strong, nonatomic) NSString<Optional>   * telephone;//座机
@property (strong, nonatomic) NSString<Optional>   * qqtoken;//QQ Token
@property (strong, nonatomic) NSString<Optional>   * weixintoken;//微信Token
@property (strong, nonatomic) NSString<Optional>   * channel;//用户所属的渠道
@property (strong, nonatomic) NSString<Optional>   * refcode;//推荐码
@property (assign, nonatomic) NSNumber<Optional>*  refuid;//推荐人Id

@property (strong, nonatomic) NSArray<NSNumber,Optional  > * fields;//加过的农田的ID

- (BOOL)isBASF;
@end
