//
//  CBASFStocksViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBASFStocksViewController.h"
#import "CGetBASFStockModel.h"
#import "CWinSafeDetailViewController.h"

@interface CBASFStocksViewController ()

@end

@implementation CBASFStocksViewController

- (void)requestData {
    CGetBASFStockParams *params = [CGetBASFStockParams new];
    
    [CGetBASFStockModel requestWithParams:params completion:^(CGetBASFStockModel *model, JSONModelError *err) {
        if(model) {
            self.dataArray = model.data;
            [self endRequestData];
        }
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CWinSafe *winsafe = self.dataArray[indexPath.row];
    cell.textLabel.text = winsafe.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CWinSafe *winsafe = self.dataArray[indexPath.row];
    CWinSafeDetailViewController *controller =  [self.storyboard instantiateViewControllerWithIdentifier:@"CWinSafeDetailViewController"];
    controller.winSafe = winsafe;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
