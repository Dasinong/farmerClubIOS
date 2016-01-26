//
//  Global.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#ifndef Global_h
#define Global_h
#import "AppDelegate.h"
#import "Config.h"

#define SharedAPPDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define currentOSVersion (floor(NSFoundationVersionNumber))

#define isiOS8	( (currentOSVersion >= NSFoundationVersionNumber_iOS_8_0) )


typedef enum
{
 ePinZhong,  //品种
 eChongHai,  //病虫草害
 eCpproduct, //农药
 eIngredient,//农药成分
 eSoil,       //测土
 eWiki,
 eXiaoChangShi
}       EType;

typedef enum
{
	eSheng,
	eShi,
	eQu,
	eZhen
} EAddressType;

typedef enum
{
	eFarm,
	eOnlyWeather
} EAddWeatherType;

#define WIND_DIRECTION_DICT @{\
@0:@"无持续风向",\
@1:@"东北风",\
@2:@"东风",\
@3:@"东南风",\
@4:@"南风",\
@5:@"西南风",\
@6:@"西风",\
@7:@"西北风",\
@8:@"北风",\
@9:@"旋转风"}

#define WIND_LEVEL_DICT @{\
@0:@"微风",\
@1:@"3-4级",\
@2:@"4-5级",\
@3:@"5-6级",\
@4:@"6-7级",\
@5:@"7-8级",\
@6:@"8-9级",\
@7:@"9-10级",\
@8:@"10-11级",\
@9:@"11-12级"}

#define WEATHER_NAME_DICT @{\
@0:@"晴",\
@1:@"多云",\
@2:@"阴",\
@3:@"阵雨",\
@4:@"雷阵雨",\
@5:@"雷阵雨伴有冰雹",\
@6:@"雨夹雪",\
@7:@"小雨",\
@8:@"中雨",\
@9:@"大雨",\
@10:@"暴雨",\
@11:@"大暴雨",\
@12:@"特大暴雨",\
@13:@"阵雪",\
@14:@"小雪",\
@15:@"中雪",\
@16:@"大雪",\
@17:@"暴雪",\
@18:@"雾",\
@19:@"冻雨",\
@20:@"沙尘暴",\
@21:@"小到中雨",\
@22:@"中到大雨",\
@23:@"大雨到暴雨",\
@24:@"暴雨到大暴雨",\
@25:@"大暴雨到特大暴雨",\
@26:@"小到中雪",\
@27:@"中到大雪",\
@28:@"大到暴雪",\
@29:@"浮尘",\
@30:@"扬沙",\
@31:@"强沙尘暴",\
@53:@"霾",\
@99:@"无"}

#define WEATHER_IMAGE_DICT @{\
@0:@"sunnyday",\
@1:@"cloudyday",\
@2:@"cloudy",\
@3:@"rainscatteredday",\
@4:@"stormday",\
@5:@"stormhail",\
@6:@"rainsnow",\
@7:@"rainsmall",\
@8:@"rainmid",\
@9:@"rainbig",\
@10:@"rainheavy",\
@11:@"rainheavier",\
@12:@"rainsevereextreme",\
@13:@"snowscatteredday",\
@14:@"snowsmall",\
@15:@"snowmid",\
@16:@"snowbig",\
@17:@"snowbigheavy",\
@18:@"fogday",\
@19:@"frozenrain",\
@20:@"duststorm",\
@21:@"rainsmallmid",\
@22:@"rainmidbig",\
@23:@"rainbigheavy",\
@24:@"rainheavyheavier",\
@25:@"rainheaviersevere",\
@26:@"snowsmallmid",\
@27:@"snowmidbig",\
@28:@"snowbigheavy",\
@29:@"dust",\
@30:@"dustmid",\
@31:@"duststormheavy",\
@53:@"haze",\
@99:@""}

#define XIAOCHANGSHI_DICT @{\
@"冷害":[kServer stringByAppendingString:@"/ploughHelper/html/Cold.html"],\
@"寒潮":[kServer stringByAppendingString:@"/ploughHelper/html/ColdWave.html"],\
@"干热风":[kServer stringByAppendingString:@"/ploughHelper/html/DryHotWind.html"],\
@"洪涝":[kServer stringByAppendingString:@"/ploughHelper/html/Flood.html"],\
@"霜":[kServer stringByAppendingString:@"/ploughHelper/html/Frost.html"],\
@"梅雨":[kServer stringByAppendingString:@"/ploughHelper/html/Rain.html"],\
@"沙尘暴":[kServer stringByAppendingString:@"/ploughHelper/html/Sandstorm.html"],\
@"土壤湿度":[kServer stringByAppendingString:@"/ploughHelper/html/Soil.html"],\
@"台风":[kServer stringByAppendingString:@"/ploughHelper/html/Typhon.html"],\
@"大风":[kServer stringByAppendingString:@"/ploughHelper/html/Wind.html"],\
}

#define SMS_Crop_Array @[\
@"水稻",\
@"小麦",\
@"芒果",\
@"大白菜",\
@"大豆",\
@"大麦",\
@"番茄",\
@"柑橘",\
@"菇",\
@"花生",\
@"黄瓜",\
@"马铃薯",\
@"棉花",\
@"苹果",\
@"葡萄",\
@"甜菜",\
@"油菜",\
@"烟草",\
@"玉米",\
@"其他",\
]

#endif /* Global_h */
