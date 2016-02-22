//
//  CAddWeatherFirstViewController.m
//  FarmNow
//
//  Created by zheliang on 15/11/6.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CAddWeatherFirstViewController.h"
#import <HorizontalProgress/HorizontalProgressView.h>
#import "FirstViewController.h"
#import "CWeatherSubscriptionModel.h"
#import "CSearchLocationByLatAndLonModel.h"

@interface CAddWeatherFirstViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet HorizontalProgressView *progress;
@property (nonatomic, assign) BOOL locationUpdated;

@property (strong, nonatomic) CLLocationManager* locationManager;
@end

@implementation CAddWeatherFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)currentLocationClick:(id)sender {
	[self openGPS];
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
	
	[CSearchLocationByLatAndLonModel requestWithParams:param completion:^(CSearchLocationByLatAndLonModel* model, JSONModelError *err) {
		if (model && err == nil) {
			CSearchLocationByLatAndLonObject* data = model.data;
			if (data) {
				gLocationId = data.locationId;
				CWeatherSubscriptionParams* params = [CWeatherSubscriptionParams new];
				params.locationId = gLocationId;
				[CWeatherSubscriptionModel requestWithParams:POST params:params completion:^(CWeatherSubscriptionModel* model, JSONModelError *err) {
					if (model) {

						
						if ( err == nil) {
							[MBProgressHUD alert:@"成功"];
							NSDictionary* info = @{@"name":model.data.locationName,
												   @"monitorLocationId":[NSNumber numberWithInteger:model.data.monitorLocationId]};
							nc_post(ChangeLocation, info);
							[self dismissViewControllerAnimated:YES completion:nil];
						}
					}
					
				}];
			}
		}
		
	}];
	
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
	[MBProgressHUD alert:@"获取当前位置出错，请稍后重试"];
	return;
	
}
- (IBAction)cancle:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
	
}

@end
