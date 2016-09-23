//
//  CDataRequestViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@interface CDataRequestViewController : CBaseViewController  <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

- (void)endRequestData;
- (void)requestData;
@end
