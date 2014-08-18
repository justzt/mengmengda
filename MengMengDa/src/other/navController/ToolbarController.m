//
//  ToolbarController.m
//  MaicheShenqi
//
//  Created by zt on 14-4-22.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "ToolbarController.h"
#import "SCToolBar.h"

@interface ToolbarController ()

@end

@implementation ToolbarController

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    CGFloat originY = [[UIScreen mainScreen] bounds].size.height- kSCToolBarHeight - (sc_systermVertion>=7 ? 0 : 20);
    self.toolbar = [[SCToolBar alloc] initWithFrame:CGRectMake(0, originY, 320, kSCToolBarHeight)];
    self.toolbar.delete = self;
    [self.view addSubview:self.toolbar];
    [self performSelector:@selector(bringToolbarToFront) withObject:nil afterDelay:0.1];
    
    self.contentHeight -= kSCToolBarHeight;
}

- (void)bringToolbarToFront{
    [self.view bringSubviewToFront:self.toolbar];
}

#pragma mark - SCToolBarDelegate
- (void)toolBar:(id)toolbar selectedButtonIndex:(int)index{}
@end
