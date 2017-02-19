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


#define RGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]  


#endif /* Macro_h */
