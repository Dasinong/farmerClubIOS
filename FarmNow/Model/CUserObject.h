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
@property (strong, nonatomic) NSString   * userName;//用户名
@property (strong, nonatomic) NSString   * cellPhone;//手机号
@property (strong, nonatomic) NSString   * address;//用户地址
@property (assign, nonatomic) BOOL       isPassSet;//是否设置过密码
@property (assign, nonatomic) BOOL       authenticated;//是否通过验证

@property (strong, nonatomic) NSString   * pictureId;//用户头像路径
@property (strong, nonatomic) NSString<Optional>   * institutionId;//代表机 构码对应的机构
@property (strong, nonatomic) NSString<Optional>   * userType;//用户头像路径

@property (strong, nonatomic) NSString   * telephone;//座机
@property (strong, nonatomic) NSString   * qqtoken;//QQ Token
@property (strong, nonatomic) NSString   * weixintoken;//微信Token
@property (strong, nonatomic) NSString   * channel;//用户所属的渠道
@property (strong, nonatomic) NSString   * refcode;//推荐码
@property (assign, nonatomic) NSNumber<Optional>*  refuid;//推荐人Id

@property (strong, nonatomic) NSArray<NSNumber,Optional  > * fields;//加过的农田的ID

@end