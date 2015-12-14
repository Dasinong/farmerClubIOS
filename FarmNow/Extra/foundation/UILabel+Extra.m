//
//  UILabel+Extra.m
//  FarmNow
//
//  Created by zheliang on 15/10/28.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "UILabel+Extra.h"
#import<CoreText/CoreText.h>

@implementation UILabel (Extra)
- (void) setHtml: (NSString*) html
{
	NSError *err = nil;
	NSMutableAttributedString* attriString =
	[[NSMutableAttributedString alloc]
	 initWithData: [html dataUsingEncoding:NSUnicodeStringEncoding]
	 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
	 documentAttributes:nil
	 error: &err];
	//改变this的字体，value必须是一个CTFontRef
	
	[attriString addAttribute:(NSString *)kCTFontAttributeName
						value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)self.font.fontName,
													   self.font.pointSize,
													   NULL))
	 range:NSMakeRange(0, attriString.length)];
	self.attributedText = attriString;
	if(err)
		NSLog(@"Unable to parse label text: %@", err);
}
@end
