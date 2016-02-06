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
#import "NSString+Extension.h"

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
@"clear":@"sunnyday",\
@"clearnight":@"sunnynight",\
@"cloudy":@"cloudy",\
@"cloudyheavyfreezingrain":@"frozenrainheavy",\
@"cloudyheavyfreezingrainlightning":@"icebigthunder",\
@"cloudyheavyfreezingrainlightningnight":@"icebigthunder",\
@"cloudyheavyfreezingrainnight":@"frozenrainheavy",\
@"cloudyheavymix":@"rainbigsnow",\
@"cloudyheavymixlightning":@"rainbigsnow",\
@"cloudyheavymixlightningnight":@"rainbigsnowthunder",\
@"cloudyheavymixnight":@"rainbigsnow",\
@"cloudyheavyrain":@"rainheavy",\
@"cloudyheavyrainlightning":@"rainheavierthunder",\
@"cloudyheavyrainlightningnight":@"rainheavierthunder",\
@"cloudyheavyrainnight":@"rainheavy",\
@"cloudyheavysleet":@"icebig",\
@"cloudyheavysleetlightning":@"icebig",\
@"cloudyheavysleetlightningnight":@"icebigthunder",\
@"cloudyheavysleetnight":@"icebig",\
@"cloudyheavysnow":@"snowbig",\
@"cloudyheavysnowlightning":@"snowbigheavythunder",\
@"cloudyheavysnowlightningnight":@"snowbigheavythunder",\
@"cloudyheavysnownight":@"snowbig",\
@"cloudylightfreezingrain":@"sunnywithfrozenrainday",\
@"cloudylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"cloudylightmix":@"sunnyrainsnowday",\
@"cloudylightmixnight":@"sunnyrainsnownight",\
@"cloudylightrain":@"rainsmall",\
@"cloudylightrainlightning":@"rainsmall",\
@"cloudylightrainlightningnight":@"rainsmallthunder",\
@"cloudylightrainnight":@"rainsmall",\
@"cloudylightsleet":@"sunnywithiceday",\
@"cloudylightsleetnight":@"sunnywithicenight",\
@"cloudylightsnow":@"snowsmall",\
@"cloudylightsnownight":@"snowsmall",\
@"cloudymediumfreezingrain":@"frozenrain",\
@"cloudymediumfreezingrainlightning":@"icemidthunder",\
@"cloudymediumfreezingrainlightningnight":@"icemidthunder",\
@"cloudymediumfreezingrainnight":@"frozenrain",\
@"cloudymediummix":@"rainmidsnow",\
@"cloudymediummixlightning":@"rainmidsnowthunder",\
@"cloudymediummixlightningnight":@"rainmidsnowthunder",\
@"cloudymediummixnight":@"rainmidsnow",\
@"cloudymediumrain":@"rainmid",\
@"cloudymediumrainlightning":@"rainmidthunder",\
@"cloudymediumrainlightningnight":@"rainmidthunder",\
@"cloudymediumrainnight":@"rainmid",\
@"cloudymediumsleet":@"sunnywithiceday",\
@"cloudymediumsleetlightning":@"icemidthunder",\
@"cloudymediumsleetlightningnight":@"icemidthunder",\
@"cloudymediumsleetnight":@"sunnywithicenight",\
@"cloudymediumsnow":@"snowmid",\
@"cloudymediumsnowlightning":@"snowmidthunder",\
@"cloudymediumsnowlightningnight":@"snowmidthunder",\
@"cloudymediumsnownight":@"snowmid",\
@"cloudynight":@"cloudy",\
@"cloudyverylightfreezingrain":@"sunnywithfrozenrainday",\
@"cloudyverylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"cloudyverylightmix":@"sunnyrainsnowday",\
@"cloudyverylightmixnight":@"sunnyrainsnownight",\
@"cloudyverylightrain":@"sunnyrainday",\
@"cloudyverylightrainnight":@"sunnyrainnight",\
@"cloudyverylightsleet":@"sunnywithiceday",\
@"cloudyverylightsleetnight":@"sunnywithicenight",\
@"cloudyverylightsnow":@"sunnysnowday",\
@"cloudyverylightsnownight":@"sunnysnownight",\
@"mostlyclear":@"cloudyday",\
@"mostlyclearheavyfreezingrain":@"frozenrainheavy",\
@"mostlyclearheavyfreezingrainlightning":@"icebigthunder",\
@"mostlyclearheavyfreezingrainlightningnight":@"icebigthunder",\
@"mostlyclearheavymix":@"rainbigsnow",\
@"mostlyclearheavymixlightning":@"rainbigsnowthunder",\
@"mostlyclearheavymixlightningnight":@"rainbigsnowthunder",\
@"mostlyclearheavymixnight":@"rainheavy",\
@"mostlyclearheavyrain":@"rainheavierthunder",\
@"mostlyclearheavyrainlightning":@"rainheavierthunder",\
@"mostlyclearheavyrainlightningnight":@"rainheavierthunder",\
@"mostlyclearheavyrainnight":@"rainheavy",\
@"mostlyclearheavysleet":@"icebig",\
@"mostlyclearheavysleetlightning":@"icebigthunder",\
@"mostlyclearheavysleetlightningnight":@"icebigthunder",\
@"mostlyclearheavysleetnight":@"icebig",\
@"mostlyclearheavysnow":@"snowbigheavy",\
@"mostlyclearheavysnowlightning":@"snowbigheavythunder",\
@"mostlyclearheavysnowlightningnight":@"snowbigheavythunder",\
@"mostlyclearheavysnownight":@"snowbigheavy",\
@"mostlyclearlightfreezingrain":@"sunnywithfrozenrainday",\
@"mostlyclearlightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"mostlyclearlightmix":@"sunnyrainsnowday",\
@"mostlyclearlightmixnight":@"sunnyrainsnownight",\
@"mostlyclearlightrain":@"rainsmall",\
@"mostlyclearlightrainlightning":@"rainsmallthunder",\
@"mostlyclearlightrainlightningnight":@"rainsmallthunder",\
@"mostlyclearlightrainnight":@"rainsmall",\
@"mostlyclearlightsleet":@"sunnywithiceday",\
@"mostlyclearlightsleetnight":@"sunnywithicenight",\
@"mostlyclearlightsnow":@"snowsmall",\
@"mostlyclearlightsnownight":@"snowsmall",\
@"mostlyclearmediumfreezingrain":@"frozenrain",\
@"mostlyclearmediumfreezingrainlightning":@"icemidthunder",\
@"mostlyclearmediumfreezingrainlightningnight":@"icemidthunder",\
@"mostlyclearmediumfreezingrainnight":@"icemidthunder",\
@"mostlyclearheavyfreezingrainnight":@"frozenrain",\
@"mostlyclearmediummix":@"rainmidsnow",\
@"mostlyclearmediummixlightning":@"rainmidsnowthunder",\
@"mostlyclearmediummixlightningnight":@"rainmidsnowthunder",\
@"mostlyclearmediummixnight":@"rainmidsnowthunder",\
@"mostlyclearmediumrain":@"rainmid",\
@"mostlyclearmediumrainlightning":@"rainmidthunder",\
@"mostlyclearmediumrainlightningnight":@"rainmidthunder",\
@"mostlyclearmediumrainnight":@"rainmid",\
@"mostlyclearmediumsleet":@"sunnywithiceday",\
@"mostlyclearmediumsleetlightning":@"icemidthunder",\
@"mostlyclearmediumsleetlightningnight":@"icemidthunder",\
@"mostlyclearmediumsleetnight":@"sunnywithicenight",\
@"mostlyclearmediumsnow":@"snowmid",\
@"mostlyclearmediumsnowlightning":@"snowmidthunder",\
@"mostlyclearmediumsnowlightningnight":@"snowmidthunder",\
@"mostlyclearmediumsnownight":@"snowmid",\
@"mostlyclearnight":@"cloudynight",\
@"mostlyclearverylightfreezingrain":@"sunnywithfrozenrainday",\
@"mostlyclearverylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"mostlyclearverylightmix":@"sunnyrainsnowday",\
@"mostlyclearverylightmixnight":@"sunnyrainsnownight",\
@"mostlyclearverylightrain":@"sunnyrainsnowday",\
@"mostlyclearverylightrainnight":@"sunnyrainsnownight",\
@"mostlyclearverylightsleet":@"sunnywithiceday",\
@"mostlyclearverylightsleetnight":@"sunnywithicenight",\
@"mostlyclearverylightsnow":@"sunnyrainsnowday",\
@"mostlyclearverylightsnownight":@"sunnyrainsnownight",\
@"mostlycloudy":@"cloudyday",\
@"mostlycloudyheavyfreezingrain":@"frozenrainheavy",\
@"mostlycloudyheavyfreezingrainlightning":@"icebigthunder",\
@"mostlycloudyheavyfreezingrainlightningnight":@"icebigthunder",\
@"mostlycloudyheavyfreezingrainnight":@"frozenrainheavy",\
@"mostlycloudyheavymix":@"rainbigsnow",\
@"mostlycloudyheavymixlightning":@"rainbigsnowthunder",\
@"mostlycloudyheavymixlightningnight":@"rainbigsnowthunder",\
@"mostlycloudyheavymixnight":@"rainbigsnow",\
@"mostlycloudyheavyrain":@"rainheavy",\
@"mostlycloudyheavyrainlightning":@"rainheavierthunder",\
@"mostlycloudyheavyrainlightningnight":@"rainheavierthunder",\
@"mostlycloudyheavyrainnight":@"rainheavy",\
@"mostlycloudyheavysleet":@"icebig",\
@"mostlycloudyheavysleetlightning":@"icebigthunder",\
@"mostlycloudyheavysleetlightningnight":@"icebigthunder",\
@"mostlycloudyheavysleetnight":@"icebig",\
@"mostlycloudyheavysnow":@"snowbigheavy",\
@"mostlycloudyheavysnowlightning":@"snowbigheavythunder",\
@"mostlycloudyheavysnowlightningnight":@"snowbigheavythunder",\
@"mostlycloudyheavysnownight":@"snowbigheavy",\
@"mostlycloudylightfreezingrain":@"sunnywithfrozenrainday",\
@"mostlycloudylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"mostlycloudylightmix":@"sunnyrainsnowday",\
@"mostlycloudylightmixnight":@"sunnyrainsnownight",\
@"mostlycloudylightrain":@"rainsmall",\
@"mostlycloudylightrainlightning":@"rainsmallthunder",\
@"mostlycloudylightrainlightningnight":@"rainsmallthunder",\
@"mostlycloudylightrainnight":@"rainsmall",\
@"mostlycloudylightsleet":@"sunnywithiceday",\
@"mostlycloudylightsleetnight":@"sunnywithicenight",\
@"mostlycloudylightsnow":@"snowsmall",\
@"mostlycloudylightsnownight":@"snowsmall",\
@"mostlycloudymediumfreezingrain":@"frozenrain",\
@"mostlycloudymediumfreezingrainlightning":@"icemidthunder",\
@"mostlycloudymediumfreezingrainlightningnight":@"icemidthunder",\
@"mostlycloudymediumfreezingrainnight":@"frozenrain",\
@"mostlycloudymediummix":@"rainmidsnow",\
@"mostlycloudymediummixlightning":@"rainmidsnowthunder",\
@"mostlycloudymediummixlightningnight":@"rainmidsnowthunder",\
@"mostlycloudymediummixnight":@"rainmidsnow",\
@"mostlycloudymediumrain":@"rainmid",\
@"mostlycloudymediumrainlightning":@"rainmidthunder",\
@"mostlycloudymediumrainlightningnight":@"rainmidthunder",\
@"mostlycloudymediumrainnight":@"rainmid",\
@"mostlycloudymediumsleet":@"sunnywithiceday",\
@"mostlycloudymediumsleetlightning":@"icemidthunder",\
@"mostlycloudymediumsleetlightningnight":@"icemidthunder",\
@"mostlycloudymediumsleetnight":@"sunnywithicenight",\
@"mostlycloudymediumsnow":@"snowmid",\
@"mostlycloudymediumsnowlightning":@"snowmidthunder",\
@"mostlycloudymediumsnowlightningnight":@"snowmidthunder",\
@"mostlycloudymediumsnownight":@"snowmid",\
@"mostlycloudynight":@"cloudynight",\
@"mostlycloudyverylightfreezingrain":@"sunnywithfrozenrainday",\
@"mostlycloudyverylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"mostlycloudyverylightmix":@"sunnyrainsnowday",\
@"mostlycloudyverylightmixnight":@"sunnyrainsnownight",\
@"mostlycloudyverylightrain":@"sunnyrainday",\
@"mostlycloudyverylightrainnight":@"sunnyrainnight",\
@"mostlycloudyverylightsleet":@"sunnywithiceday",\
@"mostlycloudyverylightsleetnight":@"sunnywithicenight",\
@"mostlycloudyverylightsnow":@"sunnysnowday",\
@"mostlycloudyverylightsnownight":@"sunnysnownight",\
@"partlycloudy":@"cloudyday",\
@"partlycloudyheavyfreezingrain":@"frozenrainheavy",\
@"partlycloudyheavyfreezingrainlightning":@"icebigthunder",\
@"partlycloudyheavyfreezingrainlightningnight":@"frozenrainheavy",\
@"partlycloudyheavyfreezingrainnight":@"frozenrainheavy",\
@"partlycloudyheavymix":@"rainbigsnow",\
@"partlycloudyheavymixlightning":@"rainbigsnowthunder",\
@"partlycloudyheavymixlightningnight":@"rainbigsnowthunder",\
@"partlycloudyheavymixnight":@"rainbigsnow",\
@"partlycloudyheavyrain":@"rainheavy",\
@"partlycloudyheavyrainlightning":@"rainheavierthunder",\
@"partlycloudyheavyrainlightningnight":@"rainheavierthunder",\
@"partlycloudyheavyrainnight":@"rainheavy",\
@"partlycloudyheavysleet":@"icebig",\
@"partlycloudyheavysleetlightning":@"icebigthunder",\
@"partlycloudyheavysleetlightningnight":@"icebigthunder",\
@"partlycloudyheavysleetnight":@"icebig",\
@"partlycloudyheavysnow":@"snowbigheavy",\
@"partlycloudyheavysnowlightning":@"snowbigheavythunder",\
@"partlycloudyheavysnowlightningnight":@"snowbigheavythunder",\
@"partlycloudyheavysnownight":@"snowbigheavy",\
@"partlycloudylightfreezingrain":@"sunnywithfrozenrainday",\
@"partlycloudylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"partlycloudylightmix":@"sunnyrainsnowday",\
@"partlycloudylightmixnight":@"sunnyrainsnownight",\
@"partlycloudylightrain":@"rainsmall",\
@"partlycloudylightrainlightning":@"rainsmallthunder",\
@"partlycloudylightrainlightningnight":@"rainsmallthunder",\
@"partlycloudylightrainnight":@"rainsmall",\
@"partlycloudylightsleet":@"sunnywithiceday",\
@"partlycloudylightsleetnight":@"sunnywithicenight",\
@"partlycloudylightsnow":@"snowsmall",\
@"partlycloudylightsnownight":@"snowsmall",\
@"partlycloudymediumfreezingrain":@"frozenrain",\
@"partlycloudymediumfreezingrainlightning":@"icemidthunder",\
@"partlycloudymediumfreezingrainlightningnight":@"icemidthunder",\
@"partlycloudymediumfreezingrainnight":@"icemidthunder",\
@"partlycloudymediummix":@"rainmidsnow",\
@"partlycloudymediummixlightning":@"rainmidsnowthunder",\
@"partlycloudymediummixnight":@"rainmidsnowthunder",\
@"partlycloudymediummixlightningnight":@"rainmidsnow",\
@"partlycloudymediumrain":@"rainmid",\
@"partlycloudymediumrainlightning":@"rainmidthunder",\
@"partlycloudymediumrainlightningnight":@"rainmidthunder",\
@"partlycloudymediumrainnight":@"rainmid",\
@"partlycloudymediumsleet":@"sunnywithiceday",\
@"partlycloudymediumsleetlightning":@"icemidthunder",\
@"partlycloudymediumsleetlightningnight":@"icemidthunder",\
@"partlycloudymediumsleetnight":@"sunnywithicenight",\
@"partlycloudymediumsnow":@"snowmid",\
@"partlycloudymediumsnowlightning":@"snowmidthunder",\
@"partlycloudymediumsnowlightningnight":@"snowmidthunder",\
@"partlycloudymediumsnownight":@"snowmid",\
@"partlycloudynight":@"cloudynight",\
@"partlycloudyverylightfreezingrain":@"sunnywithfrozenrainday",\
@"partlycloudyverylightfreezingrainnight":@"sunnywithfrozenrainnight",\
@"partlycloudyverylightmix":@"sunnyrainsnowday",\
@"partlycloudyverylightmixnight":@"sunnyrainsnownight",\
@"partlycloudyverylightrain":@"sunnyrainday",\
@"partlycloudyverylightrainnight":@"sunnyrainnight",\
@"partlycloudyverylightsleet":@"sunnywithiceday",\
@"partlycloudyverylightsleetnight":@"sunnywithicenight",\
@"partlycloudyverylightsnow":@"sunnysnowday",\
@"partlycloudyverylightsnownight":@"sunnysnownight",\
@"sunnyday":@"sunnyday",\
@"cloudyday":@"cloudyday",\
@"cloudy":@"cloudy",\
@"rainscatteredday":@"rainscatteredday",\
@"stormday":@"stormday",\
@"stormhail":@"stormhail",\
@"rainsnow":@"rainsnow",\
@"rainsmall":@"rainsmall",\
@"rainmid":@"rainmid",\
@"rainbig":@"rainbig",\
@"rainheavy":@"rainheavy",\
@"rainheavier":@"rainheavier",\
@"rainsevereextreme":@"rainsevereextreme",\
@"snowscatteredday":@"snowscatteredday",\
@"snowsmall":@"snowsmall",\
@"snowmid":@"snowmid",\
@"snowbig":@"snowbig",\
@"snowbigheavy":@"snowbigheavy",\
@"fogday":@"fogday",\
@"frozenrain":@"frozenrain",\
@"duststorm":@"duststorm",\
@"rainsmallmid":@"rainsmallmid",\
@"rainmidbig":@"rainmidbig",\
@"rainbigheavy":@"rainbigheavy",\
@"rainheavyheavier":@"rainheavyheavier",\
@"rainheaviersevere":@"rainheaviersevere",\
@"snowsmallmid":@"snowsmallmid",\
@"snowmidbig":@"snowmidbig",\
@"snowbigheavy":@"snowbigheavy",\
@"dust":@"dust",\
@"dustmid":@"dustmid",\
@"duststormheavy":@"duststormheavy",\
@"haze":@"haze",\
@"na":@"na",\
@99:@""}

#define XIAOCHANGSHI_DICT @{\
@"冷害":[kServer stringByAppendingString:@"/farmerClub/html/Cold.html"],\
@"寒潮":[kServer stringByAppendingString:@"/farmerClub/html/ColdWave.html"],\
@"干热风":[kServer stringByAppendingString:@"/farmerClub/html/DryHotWind.html"],\
@"洪涝":[kServer stringByAppendingString:@"/farmerClub/html/Flood.html"],\
@"霜":[kServer stringByAppendingString:@"/farmerClub/html/Frost.html"],\
@"梅雨":[kServer stringByAppendingString:@"/farmerClub/html/Rain.html"],\
@"沙尘暴":[kServer stringByAppendingString:@"/farmerClub/html/Sandstorm.html"],\
@"土壤湿度":[kServer stringByAppendingString:@"/farmerClub/html/Soil.html"],\
@"台风":[kServer stringByAppendingString:@"/farmerClub/html/Typhon.html"],\
@"大风":[kServer stringByAppendingString:@"/farmerClub/html/Wind.html"],\
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
