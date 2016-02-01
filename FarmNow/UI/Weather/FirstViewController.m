//
//  FirstViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UITabBarController+HideTabBar.h"
#import "CLoadWeatherModel.h"
#import "CSearchLocationByLatAndLonModel.h"
#import "CWeatherSectionView.h"
#import "LunarCalendar.h"
#import <EAIntroView/EAIntroView.h>
#import "CPersonalCache.h"
#import "CUserObject.h"
#import "CLaonongsModel.h"
#import "MJRefresh.h"

#define SuitableColor COLOR(0XFFFFFF)
#define SuitableTextColor COLOR(0X007AFF)

#define NotSuitableColor COLOR(0XF1502D)
#define NotSuitableTextColor COLOR(0XFFFFFF)

CLLocationDegrees		gLatitude = 0;
CLLocationDegrees		gLongitude = 0;
NSNumber*				gLocationId = nil;
NSString*				gLocationName = nil;

@interface FirstViewController () <CLLocationManagerDelegate>

@property (nonatomic, assign) BOOL bexpand;
@property (nonatomic, assign) BOOL locationUpdated;

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UILabel *popLabel;
@property (weak, nonatomic) IBOutlet UIButton *yixiadiBtn;
@property (weak, nonatomic) IBOutlet UIButton *yidayaoBtn;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *jieqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *nongliLabel;


@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	nc_subscribe(ChangeLocation);
	self.locationUpdated = NO;
	if (![[[CPersonalCache defaultPersonalCache] cacheValueForKey:@"first"] isEqualToString:@"NO"]) {
		[[CPersonalCache defaultPersonalCache] saveCacheValue:@"NO" forKey:@"first"];
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
		//	[intro setDelegate:self];
		intro.skipButton = nil;
		intro.tapToNext = YES;
		
		
		intro.showSkipButtonOnlyOnLastPage = YES;
		
		[intro setPages:@[page1,page2, page3, page4, page5, page6, page7]];
		[intro showFullscreen];
	}
	
	
	[self openGPS];
	// Do any additional setup after loading the view, typically from a nib.
	self.bexpand = YES;
	NSDate* date = [NSDate date];
	self.data.text = [date stringWithFormat:@"MM月d日"];
	self.weekLabel.text = [date weekdayChinese];
	LunarCalendar* lunarCalendar = [date chineseCalendarDate];
	self.nongliLabel.text = [NSString stringWithFormat:@"%@%@",[lunarCalendar MonthLunar],[lunarCalendar DayLunar]];
	self.jieqiLabel.text = [lunarCalendar SolarTermTitle];
	
	self.yixiadiBtn.layer.cornerRadius = 4.f;
	self.yixiadiBtn.layer.masksToBounds = YES;
	
	self.yidayaoBtn.layer.cornerRadius = 4.f;
	self.yidayaoBtn.layer.masksToBounds = YES;
	

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getWeatherData:nil lat:gLatitude lon:gLongitude];
    }];
}

- (void)notifyChangeLocation:(id)sender
{
	NSNotification* note = sender;
	NSDictionary* userInfo = note.userInfo;
	if (userInfo) {
		self.navigationItem.title = userInfo[@"name"];
		[self getWeatherData:userInfo[@"monitorLocationId"] lat:0 lon:0];

	}
	else
	{
		self.navigationItem.title = gLocationName;
		[self getWeatherData:nil lat:gLatitude lon:gLongitude];

	}
}

-(void)dealloc
{
	nc_unsubscribe(ChangeLocation);
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
	[self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];


}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
	[self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];


}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)leftClick:(id)sender {
	[self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:
	 nil];


}

- (void) openGPS
{
	if (self.locationManager == nil) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 越精确，越耗电！
	}
	
	[self.locationManager startUpdatingLocation]; // 开始定位
	//在ios 8.0下要授权
	
 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
	 
	 [_locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
}

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if ([identifier isEqualToString:@"weatherexpandcell"]) {
		if (![data isKindOfClass:[NSArray class]]) {
			return;
		}
		NSArray* contents = data;
		if (self.bexpand) {
			self.bexpand = !self.bexpand;
			NSMutableArray* indexPaths =[[NSMutableArray alloc] initWithCapacity:0x1];
			for (NSUInteger i = contents.count - 1; i >0; i--) {
				NSIndexPath* deleteIndex = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
				[indexPaths addObject_s:deleteIndex];
				[self.tableViewModel removeRowAtIndexPath:deleteIndex];

			}

//			for (NSIndexPath* indexPath in indexPaths) {
//				[self.tableViewModel removeRowAtIndexPath:indexPath];
//			}
			[self.tableView beginUpdates];
			[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
			[self.tableView endUpdates];
		}
		else
		{
			self.bexpand = !self.bexpand;

			
			NSMutableArray* indexPaths =[[NSMutableArray alloc] initWithCapacity:0x1];
			UITableViewModel *talbeModel = [self tableViewModel];

			for (NSUInteger i = 1; i < contents.count; i++) {
				NSIndexPath* addIndex = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
				[indexPaths addObject_s:addIndex];
				[talbeModel insertRow:TABLEVIEW_ROW(@"daycell", contents[i]) forIndexPath:addIndex];

			}

			[self.tableView beginUpdates];
			[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
			
			[self.tableView endUpdates];
		}
	}
	
	
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
	CLLocation * currLocation = [locations lastObject];
	
	
	// 取到精确GPS位置后停止更新
		// 停止更新
	[self.locationManager stopUpdatingLocation];
	if (self.locationUpdated) {
		return;
	}
	self.locationUpdated = YES;
	
	CSearchLocationByLatAndLonParams* param = [CSearchLocationByLatAndLonParams new];
	gLatitude =  param.lat = currLocation.coordinate.latitude;
	gLongitude = param.lon = currLocation.coordinate.longitude;

	[CSearchLocationByLatAndLonModel requestWithParams:param completion:^(CSearchLocationByLatAndLonModel* model, JSONModelError *err) {
		if (model && err == nil) {
			CSearchLocationByLatAndLonObject* data = model.data;
			if (data) {
				gLocationId = data.locationId;
				if ([data.province isEqualToString:data.city]) {
					gLocationName = [NSString stringWithFormat:@"%@%@%@%@", data.city, data.country, data.district, data.community];

				}
				else
				{
					gLocationName = [NSString stringWithFormat:@"%@%@%@%@%@",data.province, data.city, data.country, data.district, data.community];
			
				}

				self.navigationItem.title = gLocationName;
			}
		}

	}];
	


	[self getWeatherData:nil lat:currLocation.coordinate.latitude lon:currLocation.coordinate.longitude];

}


- (void)getWeatherData:(NSNumber*)monitorLocationId lat:(double)lat lon:(double)lon
{
    if (![self.tableView.mj_header isRefreshing]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

	CRequestBaseParams* params = nil;
	if (monitorLocationId) {
		CLoadWeatherByMonitorLocationIdParams* param = [CLoadWeatherByMonitorLocationIdParams new];
		
		param.monitorLocationId = monitorLocationId;
		params = param;
	}
	else
	{
		CLoadWeatherParams* param = [CLoadWeatherParams new];

		param.lat = lat;
		param.lon = lon;
		params = param;
	}

	
	[CLoadWeatherModel requestWithParams:params completion:^(CLoadWeatherModel* model, JSONModelError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
		[self.tableView.mj_header endRefreshing];
        
		if (model && err == nil) {
			//适宜下地
			if (model.workable) {
				[self.yixiadiBtn setTitle:@"宜下地" forState:UIControlStateNormal];
				[self.yixiadiBtn setTitleColor:SuitableTextColor forState:UIControlStateNormal];
				[self.yixiadiBtn setBackgroundColor:SuitableColor];
			}
			else{
				[self.yixiadiBtn setTitle:@"不宜下地" forState:UIControlStateNormal];
				[self.yixiadiBtn setTitleColor:NotSuitableTextColor forState:UIControlStateNormal];
				
				[self.yixiadiBtn setBackgroundColor:NotSuitableColor];
			}
			//适宜打药
			if (model.sprayable) {
				[self.yidayaoBtn setTitle:@"宜打药" forState:UIControlStateNormal];
				[self.yidayaoBtn setTitleColor:SuitableTextColor forState:UIControlStateNormal];
				
				[self.yidayaoBtn setBackgroundColor:SuitableColor];
			}
			else {
				[self.yidayaoBtn setTitle:@"不宜打药" forState:UIControlStateNormal];
				[self.yidayaoBtn setTitleColor:NotSuitableTextColor forState:UIControlStateNormal];
				
				[self.yidayaoBtn setBackgroundColor:NotSuitableColor];
			}
			//当前湿度
			self.popLabel.text = [NSString stringWithFormat:@"%@",model.soilHum];
			
			///当前天气
			UITableViewModel *talbeModel = [UITableViewModel new];
			
			[talbeModel addRow:TABLEVIEW_ROW(@"currentweathercell", model.current) forSection:0];
			[talbeModel setTitle:@"当前天气" forSection:0];
			//降水概率
			[talbeModel addRow:TABLEVIEW_ROW(@"popcell", model.POP) forSection:1];
			[talbeModel setTitle:@"今天降水概率" forSection:1];
			
			
			[talbeModel addRow:TABLEVIEW_ROW(@"hourcell", model) forSection:2];
			[talbeModel setTitle:@"24小时天气" forSection:2];
			
			//未来一周天气
			if (model.n7d.count > 0) {
				[talbeModel setTitle:@"未来一周天气" forSection:3];
				
				NSMutableArray* showDayWeathers = [[NSMutableArray alloc] initWithCapacity:0x1];
				
				for (CForecastDayInfoObject* object in model.n7d) {
					NSDate* date = [NSDate dateWithTimeIntervalSince1970:object.forecast_time / 1000];
					if ([date isToday]) {
						continue;
					}
					[talbeModel addRow:TABLEVIEW_ROW(@"daycell", object) forSection:3];
					[showDayWeathers addObject_s:object];
				}
				//				[talbeModel addRow:TABLEVIEW_ROW(@"weatherexpandcell", showDayWeathers) forSection:3];
			}
			
			
			
			
			[self updateModel:talbeModel];
			
			CLaonongsParams* paramLaonongs = [CLaonongsParams new];
			if (monitorLocationId) {
				
				paramLaonongs.monitorLocationId = monitorLocationId;
			}
			else
			{
				paramLaonongs.lat = lat;
				paramLaonongs.lon = lon;
			}

			__weak FirstViewController* weakSelf = (FirstViewController*)self;
			[CLaonongsModel requestWithParams:paramLaonongs completion:^(CLaonongsModel* model, JSONModelError *err) {
				if (model && err == nil) {
					for (CBannerObject* object in model.laonongs) {
						if (object.type == eWeatherOrNongye) {
							UITableViewModel *talbeModel = [self tableViewModel];
							if (talbeModel) {
								[talbeModel insertRowWithNewSecton:TABLEVIEW_ROW(@"laonongcell", object) forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
								[weakSelf updateModel:talbeModel];
							}
							break;

						}
					}
				}
			}];
		}
	}];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
	
	
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"CWeatherSectionView" owner:self options:nil];
	CWeatherSectionView* sectionView = [countNib objectAtIndex:0];
	
	
	NSString* title = [[self tableViewModel] titleForSection:section];
	[sectionView setTitle:title];
	
	
	return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	NSString* title = [[self tableViewModel] titleForSection:section];
	if (title) {
		return 36.0f;
	}
	else{
		return 0.0;
	}
}

@end
