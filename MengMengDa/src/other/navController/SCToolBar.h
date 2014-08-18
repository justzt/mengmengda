//
//  SCToolBar.h
//  MaicheShenqi
//
//  Created by zt on 14-4-22.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSCToolBarHeight 44

@protocol SCToolBarDelegate <NSObject>

- (void)toolBar:(id)toolbar selectedButtonIndex:(int)index;

@end

@interface SCToolBar : UIView

@property (nonatomic,weak) id<SCToolBarDelegate> delete;

// 显示toolbar顶部边框线
- (void)showTopBorder;
@end
