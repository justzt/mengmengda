//
//  SCNavigationController.h
//  MyMKNetwork
//
//  Created by zt on 14-4-17.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNavigationBar.h"

@interface SCNavigationController : UIViewController

@property (nonatomic,strong) SCNavigationBar *navBar;

@property CGFloat contentOriginY;//
@property CGFloat contentHeight;//除去navbar和toolBar之后的高度

// 处理返回事件
- (void)navigationBarBackButtonClicked:(id)navBar;
@end
