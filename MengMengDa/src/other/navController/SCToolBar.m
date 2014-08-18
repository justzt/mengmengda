//
//  SCToolBar.m
//  MaicheShenqi
//
//  Created by zt on 14-4-22.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "SCToolBar.h"
//#import "UIButton+Block.h"


@implementation SCToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.size.height = kSCToolBarHeight;
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showTopBorder{
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, .5)];
    line.backgroundColor = [UIColor lightGrayColor];//ColorWithRGB(241, 239, 236);
    [self addSubview:line];
}

/*
- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    
    if ([view isKindOfClass:[UIButton class]]) {
        int tag = ((UIButton*)view).tag;
        [(UIButton*)view setTouchUpInsideBlock:^{
            if (self.delete && [self.delete respondsToSelector:@selector(toolBar:selectedButtonIndex:)]) {
                [self.delete toolBar:self selectedButtonIndex:tag];
            }
        }];
    }
}
 */
@end
