//
//  SCNavigationController.m
//  MyMKNetwork
//
//  Created by zt on 14-4-17.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "SCNavigationController.h"

@interface SCNavigationController ()<SCNavigationBarDelegate>

@end

@implementation SCNavigationController

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //status Bar 白色字体
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = ColorWithRGB(242, 240, 237);
    
    // add nav bar
    [self addNavBar];
}

- (void)addNavBar{
    if (self.navBar == nil) {
        self.navBar = [[SCNavigationBar alloc] init];
        self.navBar.delegate = self;
        [self.view addSubview:_navBar];
        
        self.contentOriginY = CGRectGetHeight(self.navBar.frame);
        self.contentHeight = CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.navBar.frame);
    }
}

- (void)setTitle:(NSString *)title{
    [self addNavBar];
    self.navBar.titleLabel.text = title;
    CGSize size = [title sizeWithFont:self.navBar.titleLabel.font constrainedToSize:CGSizeMake(3000, CGRectGetHeight(self.navBar.titleLabel.frame))];
    CGRect frame = self.navBar.titleLabel.frame;
    frame.size.width = size.width+10;
//    self.navBar.titleLabel.frame = frame;
}

#pragma mark - SCNavigationBarDelegate
- (void)navigationBarBackButtonClicked:(id)navBar{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
