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

@interface CRetailerHomeViewController () <UITableViewDataSource, UITableViewDelegate, QRCodeReaderDelegate, CStockViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) QRCodeReaderViewController* reader;
@end


@implementation CRetailerHomeViewController

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
            if (self.reader) {
                [self presentViewController:self.reader animated:YES completion:NULL];
            }
            
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

- (QRCodeReaderViewController *)reader {
    if (_reader == nil) {
        NSArray *types = @[AVMetadataObjectTypeQRCode];
        // check permission
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusAuthorized) {
            _reader = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
            
            // Using delegate methods
            _reader.delegate = self;
        } else {
            [MBProgressHUD alert:@"请打开摄像机权限"];
        }
    }
    
    return _reader;
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
        
        [CUtil processQR:result inVC:self];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - CStockViewControllerDelegate
- (void)continueScan {
    if (self.reader) {
        [self presentViewController:self.reader animated:YES completion:NULL];
    }
}
@end
