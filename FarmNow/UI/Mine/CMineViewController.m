//
//  CMineViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/19.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CMineViewController.h"
#import "CWebViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <EAIntroView/EAIntroView.h>
#import "CRecommendController.h"
#import "CPersonalCache.h"
#import "CSubScribeListController.h"
#import "CRecommendController1.h"
#import "CMyCouponContainerViewController.h"
#import "CRedeemCouponModel.h"
#import "CScannedCouponDetailViewController.h"
#import "CUtil.h"

@interface CMineViewController () <QRCodeReaderDelegate>
@property (strong, nonatomic) QRCodeReaderViewController* reader;

@end

@implementation CMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	UITableViewModel* tableModel = [UITableViewModel new];
	
    [tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"个人信息") forSection:0];
    [tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"我的活动") forSection:0];
    [tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"我的达人积分") forSection:0];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"扫一扫") forSection:1];
    [tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"我的二维码") forSection:1];
	//[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"免费短信订阅") forSection:1];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"帮助中心") forSection:2];
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"使用教程") forSection:2];

	//[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"联系我们") forSection:3];
    
	[self updateModel:tableModel];
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
	if (object) {
		self.navigationItem.rightBarButtonItem = nil;
	}
	else
	{
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginClick:)];
	}
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)showMyCoupons {
    if (USER != nil) {
        if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
            return NO;
        }
    }
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //审核时隐藏有奖推荐
    if (!SharedAPPDelegate.showWXLogin && indexPath.section == 1 && indexPath.row == 1) {
        return 0;
    }
    
    if (![self showMyCoupons] && indexPath.section == 1 && indexPath.row == 2) {
        return 0;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (![delegate enableWelfare]) {
            return 0;
        }
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        BOOL isDaren = NO;
        if ([USER_DEFAULTS objectForKey:@"clientConfig"]) {
            NSDictionary *clientConfig = [USER_DEFAULTS objectForKey:@"clientConfig"];
            if (clientConfig[@"isDaren"]) {
                if ([clientConfig[@"isDaren"] boolValue]) {
                    isDaren = YES;
                }
            }
        }
        
        if (!isDaren) {
            return 0;
        }
    }
    
    return 44;
}
- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (USER) {
                [self performSegueWithIdentifier:@"Personal" sender:self];
            }
            else {
                [self loginClick:nil];
            }
        }
        else if (indexPath.row == 1)
        {
            if (USER) {
                CMyCouponContainerViewController *controller = [self.storyboard controllerWithID:@"CMyCouponContainerViewController"];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
            else {
                [self loginClick:nil];
            }
        }
        else if (indexPath.row == 2)
        {
            if (USER) {
                CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
                webController.title = @"达人积分";
                webController.address = [NSString stringWithFormat:@"%@/daren?userId=%d", kServerAddress, (int)USER.userId];
                NSLog(@"%@",webController.address);
                webController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webController animated:YES];
            }
            else {
                [self loginClick:nil];
            }
        }
	}
	else if (indexPath.section == 1)
	{
		if (indexPath.row == 0) {
            if (USER) {
                [self presentViewController:self.reader animated:YES completion:NULL];
            }
            else {
                [self loginClick:nil];
            }
		}
		else if (indexPath.row == 1)
		{
            if (USER) {
                CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
                if (object.institutionId != nil || object.refuid != nil)
                {
                    CRecommendController1* controller  = [self.storyboard controllerWithID:@"CRecommendController1"];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    CRecommendController* controller  = [self.storyboard controllerWithID:@"CRecommendController"];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }
            else {
                [self loginClick:nil];
            }
		}
        else if (indexPath.row == 2)
        {
            if (USER) {
                CSubScribeListController* controller = [self.storyboard controllerWithID:@"CSubScribeListController"];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
            else {
                [self loginClick:nil];
            }
        }
	}
	else if (indexPath.section == 2){
		if (indexPath.row == 0) {
			CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
			webController.title                     = data;
            webController.address = [NSString stringWithFormat:@"%@html/HelpCenter.html", kAPIServer];
            webController.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:webController animated:YES];
		}
		else if (indexPath.row == 1){
			EAIntroPage *page1 = [EAIntroPage page];
			page1.bgImage = IMAGE(@"app001");
			EAIntroPage *page2 = [EAIntroPage page];
			page2.bgImage = IMAGE(@"app002");
			
			EAIntroPage *page3 = [EAIntroPage page];
			page3.bgImage = IMAGE(@"app003");
			EAIntroPage *page4 = [EAIntroPage page];
			page4.bgImage = IMAGE(@"app004");
			EAIntroPage *page5 = [EAIntroPage page];
			page5.bgImage = IMAGE(@"app005");
			EAIntroPage *page6 = [EAIntroPage page];
			page6.bgImage = IMAGE(@"app006");
			EAIntroPage *page7 = [EAIntroPage page];
			page7.bgImage = IMAGE(@"app007");
			
			EAIntroView *intro = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, HSScreenBounds().size.width, HSScreenBounds().size.height) andPages:@[page1,page2,page3,page4]];
			[intro setDelegate:self];
//			self.skipBtn.layer.masksToBounds = YES;
//			self.skipBtn.layer.cornerRadius = 5.0;
			intro.skipButton = nil;
			intro.showSkipButtonOnlyOnLastPage = YES;
			intro.tapToNext = YES;
			[intro setPages:@[page1,page2, page3, page4, page5, page6, page7]];
			[intro showFullscreen];
//			CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
//			webController.title                     = data;
//			webController.address = [NSString stringWithFormat:@"%@html/soiltest-sample.html", kAPIServer];
//			[self.navigationController pushViewController:webController animated:YES];
		}
	}
		
	else if (indexPath.section == 3){
		[self performSegueWithIdentifier:@"contactus" sender:self];
	}
}

- (IBAction)loginClick:(id)sender {
	UINavigationController* naviController = [self.storyboard controllerWithID:@"loginNavigationController"];
	[self presentViewController:naviController animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([delegate.jumpState isEqualToString:@"qr"]) {
        [self presentViewController:self.reader animated:YES completion:NULL];
    }
    
    delegate.jumpState = nil;
}

- (QRCodeReaderViewController *)reader {
    if (_reader == nil) {
        NSArray *types = @[AVMetadataObjectTypeQRCode];
        _reader = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
        
        // Using delegate methods
        _reader.delegate = self;
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
@end
