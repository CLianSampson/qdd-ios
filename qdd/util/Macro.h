//
//  Macro.h
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//屏幕宽度
#define SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)//屏幕高度

#define SUPER_WIDTH   (self.frame.size.width)
#define SUPER_HEIGHT  (self.frame.size.height)

#define SCALE [UIScreen mainScreen].scale

#define WIDTH    SCREEN_WIDTH*SCALE
#define HEIGHT   SCREEN_HEIGHT*SCALE

#define IPONE6_WIDTH 750
#define IPONE6_HEIGHT 1334


#define WIDTH_SCALE  WIDTH/IPONE6_WIDTH/SCALE
#define HEIGHT_SCALE  HEIGHT/IPONE6_HEIGHT/SCALE


#define MainScreen     [[UIScreen mainScreen] bounds]

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/ 255.0 alpha:1]  

//分割线颜色 
#define SepreateRGBColor [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/ 255.0 alpha:1]

//系统红色
#define RedRGBColor [UIColor colorWithRed:255/255.0 green:17/255.0 blue:17/ 255.0 alpha:1]

//系统灰色
#define GrayRGBColor [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/ 255.0 alpha:1]

//文字
#define TextRGBColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/ 255.0 alpha:1]

//系统蓝色
#define BlueRGBColor [UIColor colorWithRed:0/255.0 green:51/255.0 blue:102/ 255.0 alpha:1]

//占位符
#define PlaceHoderRGBColor [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/ 255.0 alpha:1]



#define RGRectMake(view,w,h)  CGRectMake((view).frame.origin.x+(view).frame.size.width, (view).frame.origin.y+(view).frame.size.height, (w)*WIDTH_SCALE, (h)*height)

#endif /* Macro_h */
