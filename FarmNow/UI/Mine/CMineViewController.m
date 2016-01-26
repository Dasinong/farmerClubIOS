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

@interface CMineViewController () <QRCodeReaderDelegate>
@property (strong, nonatomic) QRCodeReaderViewController* reader;

@end

@implementation CMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	UITableViewModel* tableModel = [UITableViewModel new];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"个人信息") forSection:0];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"扫一扫") forSection:1];
	//审核时隐藏有奖推荐
	if (SharedAPPDelegate.showWXLogin) {

	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"有奖推荐") forSection:1];
	}
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"免费短信订阅") forSection:1];
	
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"帮助中心") forSection:2];
	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"使用教程") forSection:2];

	[tableModel addRow:TABLEVIEW_ROW(@"contentcell", @"联系我们") forSection:3];

	
	[self updateModel:tableModel];
	
	NSArray *types = @[AVMetadataObjectTypeQRCode];
	self.reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];

	// Using delegate methods
		self.reader.delegate = self;
	
//	// Or use blocks
//	[self.reader setCompletionWithBlock:^(NSString *resultAsString) {
//		NSLog(@"%@", resultAsString);
//	}];
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

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	if (indexPath.section == 0) {
		[self performSegueWithIdentifier:@"Personal" sender:self];
	}
	else if (indexPath.section == 1)
	{
		if (indexPath.row == 0) {
			// Create the reader object


			
			[self presentViewController:_reader animated:YES completion:NULL];
		}
		else if (indexPath.row == 1)
		{
			if (SharedAPPDelegate.showWXLogin) {
				CUserObject* object = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
				if (object.institutionId != nil || object.refuid != nil)
				{
					CRecommendController1* controller  = [self.storyboard controllerWithID:@"CRecommendController1"];
					controller.topViewHeight.constant = 0;
					controller.title = @"有奖推荐";
					
					[self.navigationController pushViewController:controller animated:YES];
				}
				else
				{
					CRecommendController* controller  = [self.storyboard controllerWithID:@"CRecommendController"];
					[self.navigationController pushViewController:controller animated:YES];
				}
			}
			else{
				CSubScribeListController* controller = [self.storyboard controllerWithID:@"CSubScribeListController"];
				[self.navigationController pushViewController:controller animated:YES];
			}
			

		}
		else if (indexPath.row == 2)
		{
			CSubScribeListController* controller = [self.storyboard controllerWithID:@"CSubScribeListController"];
			[self.navigationController pushViewController:controller animated:YES];
		}
	}
	else if (indexPath.section == 2){
		if (indexPath.row == 0) {
			CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
			webController.title                     = data;
			webController.address = [NSString stringWithFormat:@"%@html/HelpCenter.html", kAPIServer];
			[self.navigationController pushViewController:webController animated:YES];
		}
		else if (indexPath.row == 1){
			EAIntroPage *page1 = [EAIntroPage page];
			page1.bgImage = IMAGE(@"app001");
			EAIntroPage *page2 = [EAIntroPage page];
			page2.bgImage = IMAGE(@"app005");
			
			EAIntroPage *page3 = [EAIntroPage page];
			page3.bgImage = IMAGE(@"app003");
			EAIntroPage *page4 = [EAIntroPage page];
			page4.bgImage = IMAGE(@"app006");
			EAIntroPage *page5 = [EAIntroPage page];
			page5.bgImage = IMAGE(@"app003");
			EAIntroPage *page6 = [EAIntroPage page];
			page6.bgImage = IMAGE(@"app007");
			EAIntroPage *page7 = [EAIntroPage page];
			page7.bgImage = IMAGE(@"app004");
			
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

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
	[self dismissViewControllerAnimated:YES completion:^{
		NSLog(@"%@", result);
		CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
//		webController.title                     = data;
		webController.address = result;
		webController.hideToolbar = NO;
		[self.navigationController pushViewController:webController animated:YES];
	}];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}
@end
