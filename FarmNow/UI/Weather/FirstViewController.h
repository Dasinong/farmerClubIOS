//
//  FirstViewController.h
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import "CTableViewController_StoryBoard.h"
#import <CoreLocation/CoreLocation.h>

extern CLLocationDegrees gLatitude;
extern CLLocationDegrees gLongitude;
extern NSNumber* gLocationId;
extern NSString* gLocationName;

@interface FirstViewController : CTableViewController_StoryBoard


@end

