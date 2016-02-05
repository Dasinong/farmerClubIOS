//
//  CWeatherLeftController.m
//  FarmNow
//
//  Created by zheliang on 15/10/28.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherLeftController.h"
#import "CAllWeatherSubscriptionModel.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "CReorderWeatherSubscriptionsModel.h"
#import "CDeleteWeatherSubscriptionModel.h"
#import "CSearchLocationByLatAndLonModel.h"
#import "FirstViewController.h"
#import "CPersonalCache.h"

@interface CWeatherLeftController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *naviItem;
@property (strong, nonatomic)  NSMutableArray *orderContens;
@property (weak, nonatomic) IBOutlet UIImageView *localWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *localWeatherLabel;
@property (nonatomic, assign) BOOL locationUpdated;

@property (strong, nonatomic) CLLocationManager* locationManager;
@end

@implementation CWeatherLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//	self.lo
//	[self getWeatherSubscription];
	self.orderContens = [[NSMutableArray alloc] initWithCapacity:0x1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.localWeatherLabel.text = gLocationName;
	[self getWeatherSubscription];
    
    if ([[CPersonalCache defaultPersonalCache] cacheUserInfo] == nil) {
        // 登出
        [self.orderContens removeAllObjects];
        UITableViewModel* tableModel = [UITableViewModel new];
        [self updateModel:tableModel];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)reLocation:(id)sender {
	[self openGPS];
}
- (IBAction)clickLocal:(id)sender {

	nc_post(ChangeLocation, nil);
	[self.mm_drawerController closeDrawerAnimated:YES completion:nil];

//	if (<#condition#>) {
//		<#statements#>
//	}
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
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];

	[CSearchLocationByLatAndLonModel requestWithParams:param completion:^(CSearchLocationByLatAndLonModel* model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
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
				self.localWeatherLabel.text = gLocationName;
			}
		}
		
	}];
	
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
	[MBProgressHUD alert:@"获取当前位置出错，请稍后重试"];
	return;
	
}
- (IBAction)add:(id)sender {
	if (self.tableView.editing) {
		[self finishEdit];
	}
	else
	{
		[self performSegueWithIdentifier:@"addWeather" sender:sender];
	}
}
- (IBAction)edit:(id)sender {
	if (self.tableView.editing) {
		[self finishEdit];
	}
	else{
		[self beginEdit];
	}

//	[self.tableView setEditing:YES];
}

- (void)beginEdit
{
	[self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

	__weak CWeatherLeftController* weakSelf = self;
		[self.mm_drawerController setMaximumLeftDrawerWidth:HSScreenBounds().size.width animated:YES completion:^(BOOL finished) {
			[weakSelf.tableView setEditing:YES];
			weakSelf.naviItem.leftBarButtonItem = nil;
			weakSelf.naviItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(add:)];
			weakSelf.naviItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
		}];
		



}

- (void)finishEdit
{
	CReorderWeatherSubscriptionsParams* params = [CReorderWeatherSubscriptionsParams new];
	params.ids = self.orderContens;
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[CReorderWeatherSubscriptionsModel requestWithParams:POST params:params completion:^(CReorderWeatherSubscriptionsModel* model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];

		if (model && err ==nil) {
			
		}
	}];
	__weak CWeatherLeftController* weakSelf = self;
	
	[self.mm_drawerController setMaximumLeftDrawerWidth:HSScreenBounds().size.width - 100 animated:YES completion:^(BOOL finished) {
		[weakSelf.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

		[weakSelf.tableView setEditing:NO];
		weakSelf.naviItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(edit:)];
		weakSelf.naviItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
		
		weakSelf.naviItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:weakSelf action:@selector(add:)];
		weakSelf.naviItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
	}];

}

- (void)getWeatherSubscription
{
	[self.orderContens removeAllObjects];
	CAllWeatherSubscriptionParams* params = [CAllWeatherSubscriptionParams new];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[CAllWeatherSubscriptionModel requestWithParams:params completion:^(CAllWeatherSubscriptionModel* model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];

		if (model && err == nil) {

			if ([model isKindOfClass:[CAllWeatherSubscriptionModel class]]) {
				UITableViewModel* tableModel = [UITableViewModel new];
				for (CWeatherSubscriptionItem* item in model.data) {
					[tableModel addRow:TABLEVIEW_ROW(@"positioncell", item) forSection:0];
					[self.orderContens addObject_s:[NSNumber numberWithInteger:item.weatherSubscriptionId]];
				}
				[self updateModel:tableModel];
			}

		}
	}];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}


-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	[self.orderContens exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
	[self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
//	[_dataSource exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.orderContens removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
		CWeatherSubscriptionItem* item = [self.tableViewModel modelForRowAtIndexPath:indexPath].data;
	
		[self deleteRowsAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
		CDeleteWeatherSubscriptionParams* params = [CDeleteWeatherSubscriptionParams new];
		params.id = item.weatherSubscriptionId;
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CDeleteWeatherSubscriptionModel deleteWithParams:params pathParams:[NSString stringWithFormat:@"%ld", (long)item.weatherSubscriptionId] completion:^(id model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			if (model && err == nil) {
				[MBProgressHUD alert:@"删除成功"];
			}
		}];
	}
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the item to be re-orderable.
	return YES;
}

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString *)identifier data:(id)data
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	CWeatherSubscriptionItem* item = data;
	NSDictionary* info = @{@"name":item.locationName,
							  @"monitorLocationId":[NSNumber numberWithInteger:item.monitorLocationId]};
	nc_post(ChangeLocation, info);
	[self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

@end
