//
//  UIColor+HexToRgb.h
//  MaiChe2
//
//  Created by zt on 13-12-18.
//  Copyright (c) 2013年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexToRgb)
// 16进制color to uicolor
+ (UIColor *)colorWithHexStr:(NSString *)hexStr;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha;
@end
