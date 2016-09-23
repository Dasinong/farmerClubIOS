//
//  CRetailerHomeViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/8.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CRetailerHomeViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import "CUtil.h"
#import "CMyStoreViewController.h"
#import "CPersonalController.h"
#import "CBASFStocksViewController.h"
#import "ScannerViewController.h"

@interface CRetailerHomeViewController () <UITableViewDataSource, UITableViewDelegate, CStockViewControllerDelegate, ScannerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation CRetailerHomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([delegate.jumpState isEqualToString:@"qr"]) {
        [self openScanner];
    }
    
    delegate.jumpState = nil;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
    
    switch (indexPath.row) {
        case 0:
            [imageView setImage:[UIImage image_s:@"retailer_camera"]];
            titleLabel.text = @"扫一扫";
            break;
        case 1:
            [imageView setImage:[UIImage image_s:@"retailer_coupon"]];
            titleLabel.text = @"活动券管理";
            break;
        case 2:
            [imageView setImage:[UIImage image_s:@"retailer_info"]];
            titleLabel.text = @"店铺基本信息";
            break;
        case 3:
            [imageView setImage:[UIImage image_s:@"retailer_stock"]];
            titleLabel.text = @"入库管理";
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self openScanner];
            break;
        case 1: {
            CMyStoreViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CMyStoreViewController"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2: {
            CPersonalController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CPersonalController"];
            controller.isRetail = YES;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 3: {
            CBASFStocksViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CBASFStocksViewController"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            
        default:
            break;
    }
}

- (void)openScanner {
    // check permission
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined || authStatus == AVAuthorizationStatusAuthorized) {
        ScannerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
    } else {
        [MBProgressHUD alert:@"请打开摄像机权限"];
    }
}


#pragma mark - QRCodeReader Delegate Methods
- (void)scanned:(NSString *)scanned {
    [CUtil processQR:scanned inVC:self];
}


#pragma mark - CStockViewControllerDelegate
- (void)continueScan {
    [self openScanner];
}
@end
