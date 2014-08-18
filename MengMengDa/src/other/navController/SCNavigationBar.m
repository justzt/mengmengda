//
//  SCNavigationBar.m
//  MyMKNetwork
//
//  Created by zt on 14-4-17.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "SCNavigationBar.h"

#define kNavBarHeight 44

@implementation SCNavigationBar

- (id)init{
    self = [super init];
    if (self) {
        self.originY = sc_systermVertion>=7 ? 20 : 0;
        [self setBarFrame];
        [self addBackButton];
        [self addTitleLabel];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    SCNavigationBar *bar = [[SCNavigationBar allocWithZone: zone]init];
    return bar;
}

// bar 的frame
- (void)setBarFrame{
    CGRect frame = CGRectMake(0, 0, 320, kNavBarHeight);
    if (sc_systermVertion >= 7) {
        frame.size.height = kNavBarHeight+20;
    }
    self.frame = frame;
    //rgb(255, 135, 73)
    self.backgroundColor = ColorWithRGB(255, 204, 92);;
}

// 表题
- (void)addTitleLabel{
    if (self.titleLabel == nil) {
        CGFloat originX = CGRectGetMaxX(self.backButton.frame)+5;
        CGFloat width = 320-originX*2;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, CGRectGetHeight(self.frame)-kNavBarHeight, width, kNavBarHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.userInteractionEnabled = YES;
        [self addSubview:_titleLabel];
    }
}

// 返回按钮
- (void)addBackButton{
    CGFloat widht = 70; CGFloat height = 35;
    UIImage *backImage = ImageWithName(@"backButton@2x");
    CGFloat originY = (kNavBarHeight-height)/2 + (sc_systermVertion>=7 ? 20 : 0);
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(-15, originY, widht, height);
    [_backButton setImage:backImage forState:UIControlStateNormal];
    _backButton.backgroundColor = [UIColor clearColor];
    [_backButton setContentMode:UIViewContentModeRight];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
}

// 返回按钮action
- (void)backButtonAction{
    DLogF(@"nav delegate:%@, nav:%@", self.delegate,self);
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarBackButtonClicked:)]) {
        [self.delegate navigationBarBackButtonClicked:self];
    }
}
@end
