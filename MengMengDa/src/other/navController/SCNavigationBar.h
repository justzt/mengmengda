//
//  SCNavigationBar.h
//  MyMKNetwork
//
//  Created by zt on 14-4-17.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCNavigationBarDelegate <NSObject>

@required
- (void)navigationBarBackButtonClicked:(id)navBar;

@end

@interface SCNavigationBar : UIView <NSCopying>
@property float originY;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,weak) id<SCNavigationBarDelegate> delegate;
@end
