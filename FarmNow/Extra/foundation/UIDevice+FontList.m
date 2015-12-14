//
//  UIDevice+FontList.m
//  HomeService
//
//  Created by liangzhe on 14-7-7.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "UIDevice+FontList.h"

@implementation UIDevice (FontList)
+ (void)allFonts
{
    NSArray *familyNames = [UIFont familyNames];
    NSUInteger numberOfFamilies = [familyNames count];

    for(int indFamily = 0; indFamily < numberOfFamilies; ++indFamily)
    {
        Info(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        NSArray *fontNames    = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]];
        NSUInteger numberOfFontNames = [fontNames count];
        for(int indFont = 0; indFont < numberOfFontNames; ++indFont)
        {
            Info(@"\tFont name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
} /* dumpFonts */

@end
