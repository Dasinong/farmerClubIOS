//
//  CPetDisListViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CDataRequestViewController.h"
#import "CPetDisSpec.h"

@interface CPetDisListViewController : CDataRequestViewController
@property (nonatomic, strong) CPetDisSpec *petDis;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL goToSolution;
@end
