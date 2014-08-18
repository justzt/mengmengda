//
//  SCHudManager.h
//  MaiChe2
//
//  Created by zt on 13-12-13.
//  Copyright (c) 2013年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define kHudErrorImage      [UIImage imageNamed:@"hudError"]
#define kHudOKImage         [UIImage imageNamed:@"HUDCheckmark"]

@interface SCHudManager : NSObject

+(UIWindow*)window;

+(MBProgressHUD*)showHUD;

+ (void)hiddenHud;

//加载带图片和标题的hud
+ (void)showHudWithImage:(UIImage*)image title:(NSString*)title;

// 详情hud
+ (void)showHudWithTitle:(NSString*)title detailTitle:(NSString*)detailTitle image:(UIImage*)image;

@end
