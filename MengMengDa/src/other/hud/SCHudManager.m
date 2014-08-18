//
//  SCHudManager.m
//  MaiChe2
//
//  Created by zt on 13-12-13.
//  Copyright (c) 2013年 zt. All rights reserved.
//

#import "SCHudManager.h"

#define kHudDefaultBGColor ColorWithRGB(242, 243, 243)


@implementation SCHudManager

+(UIWindow*)window{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

MBProgressHUD *HUD;

+(MBProgressHUD*)showHUD{
    [self hiddenHud];
    
    HUD = [MBProgressHUD showHUDAddedTo:[self window] animated:YES];
    //pHUD.color = [UIColor clearColor];
//    HUD.userInteractionEnabled = NO;//loading时不禁用用户操作
    
    HUD.mode = MBProgressHUDModeIndeterminate;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudTouchAction:)];
//    [HUD addGestureRecognizer:tapGesture];
    
    return HUD;
}


+(void)hudTouchAction:(UITapGestureRecognizer*)recogenizer{
    if (recogenizer.state == UIGestureRecognizerStateEnded) {
        [self hiddenHud];
    }
}

// 详情hud
+ (void)showHudWithTitle:(NSString*)title detailTitle:(NSString*)detailTitle image:(UIImage*)image{
    [self showHUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
	HUD.labelText = title;
	HUD.detailsLabelText = detailTitle;
	HUD.square = YES;
    [self autoHiddenHudWithDelay:2];
}

//加载带图片和标题的hud
+ (void)showHudWithImage:(UIImage*)image title:(NSString*)title{
    [self showHUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabelText = nil;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.labelText = title;
    [self autoHiddenHudWithDelay:2];
}

+ (void)autoHiddenHudWithDelay:(int)delay{
    [self performSelector:@selector(hiddenHud) withObject:nil afterDelay:delay];
}

+ (void)hiddenHud{
     [MBProgressHUD hideAllHUDsForView:[self window] animated:NO];
}
@end
