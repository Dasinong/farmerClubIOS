//
//  CContactusController.m
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CContactusController.h"

@implementation CContactusController
- (IBAction)mail:(id)sender {
	[self launchMailApp];
}

- (IBAction)phone:(id)sender {
	
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4005506050"];
	UIWebView * callWebview = [[UIWebView alloc] init];
	[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
	[self.view addSubview:callWebview];

}

#pragma mark - 使用系统邮件客户端发送邮件
-(void)launchMailApp
{
	NSMutableString *mailUrl = [[NSMutableString alloc]init];
	//添加收件人
	NSArray *toRecipients = [NSArray arrayWithObject: @"cs@dasinong.net"];
	[mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];

	NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
@end
