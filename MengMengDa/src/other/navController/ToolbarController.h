//
//  ToolbarController.h
//  MaicheShenqi
//
//  Created by zt on 14-4-22.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "SCNavigationController.h"

#import "SCToolBar.h"

@interface ToolbarController : SCNavigationController<SCToolBarDelegate>
@property (nonatomic,strong) SCToolBar *toolbar;
@end
