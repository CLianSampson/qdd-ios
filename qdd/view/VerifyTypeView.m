//
//  VerifyTypeView.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "VerifyTypeView.h"
#import "Macro.h"

@implementation VerifyTypeView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=RGBColor(245, 245, 245);
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(48*WIDTH_SCALE, 0, self.frame.size.width-48*WIDTH_SCALE, self.frame.size.height)];
        label.text=@"认证方式: 银行卡认证";
        label.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:label];
        
        UILabel *underBackground =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, SCREEN_WIDTH, 1)];
        underBackground.backgroundColor=SepreateRGBColor;
        [self addSubview:underBackground];
        
    }
    
    return  self;
}

@end
