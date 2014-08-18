//
//  UIColor+HexToRgb.m
//  MaiChe2
//
//  Created by zt on 13-12-18.
//  Copyright (c) 2013年 zt. All rights reserved.
//

#import "UIColor+HexToRgb.h"

@implementation UIColor (HexToRgb)

// Convert Hex String To Integer
+ (unsigned int)intFromHexString:(NSString *)hexStr{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

// 16进制color to uicolor
+ (UIColor *)colorWithHexStr:(NSString *)hexStr {
    return [self colorWithHexStr:hexStr alpha:1];
}

+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha < 0 ? 1 : alpha];
    
    return color;
}
@end
