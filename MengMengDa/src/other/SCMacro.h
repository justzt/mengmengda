//
//  SCMacro.h
//  MyMKNetwork
//
//  Created by zt on 14-4-17.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#ifndef MyMKNetwork_SCMacro_h
#define MyMKNetwork_SCMacro_h

// 必要的头文件
#import "SCNavigationController.h"
#import "UIColor+HexToRgb.h"
#import "ToolbarController.h"
#import "SCHudManager.h"

#define SCDEBUG

#if defined(SCDEBUG)
#   define DLog(A) NSLog((@"%@(%d): %@"),[[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__, A)
#   define DLogF(fmt, ...)  NSLog((@"%@(%d): " fmt),[[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__)
#else
#   define DLog(A)
#   define DLogF(fmt, ...)
#endif

//主题颜色，橘色
#define kMaicheMainColor ColorWithRGB(255, 204, 92)
// ios版本
#define sc_systermVertion  [[UIDevice currentDevice] systemVersion].intValue

//设备类型
#define iphone5 ([[UIScreen mainScreen] bounds].size.height > 480 ? YES : NO)

// rgb to uicolor
#define ColorWithRGB(a,b,c) [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:1]

// 根据名字返回UIImage
#define ImageWithName(name)  ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]])

// 根据xib的名字加在xib
#define LoadNibWithName(name) ([[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0])

// 根据图片的名字加载png
#define ImageWithName(name)  ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]])

// 设置view的圆角，边框，
#define viewroundCorner(view,color,width,radio) (view.layer.borderColor=color.CGColor); (view.layer.borderWidth=width); (view.layer.cornerRadius=radio);

// 字符串格式化
#define FormatStr(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

// NSNumber to string
#define NSNumberToStr(D)    FormatStr(@"%@",D)

// userdefaults
#define UserDefaults [NSUserDefaults standardUserDefaults]

// 同步 userdefaults
#define syncUserDefaults [UserDefaults synchronize]

// 将nil NULL 转成 @""
#define strNoNull(a) (([a isKindOfClass:[NSNull class]] || a == nil) ? @"" : a)

// replace nil with @""
#define replaceNil(a,b) ((a == nil || [a isKindOfClass:[NSNull class]]) ? b : a)

//判断是否是 NSNull
#define objIsNSNull(obj) [obj isKindOfClass:[NSNull class]] ? YES : NO

//dictionatry 取值NULL处理, 为空的话用给定的defultValue作为默认值
#define DicValueForKey(dic,defultValue,key) [[dic objectForKey:key] class] ==  [NSNull class] ? defultValue : [dic objectForKey:key]

//根据index获取字典的value
#define dicValueAtIndex(dic,index) ([dic objectForKey:[[dic allKeys] objectAtIndex:index]])
#endif
