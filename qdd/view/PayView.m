//
//  PayView.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "PayView.h"
#import "Macro.h"

@implementation PayView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(46*WIDTH_SCALE, (frame.size.height-30)/2, 30, 30)];
        
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x+_icon.frame.size.width+47*WIDTH_SCALE, 0, 150, frame.size.height)];
        _name.text=@"支付宝";
        _name.textColor=RGBColor(0, 0, 0);
        _name.font=[UIFont systemFontOfSize:18];
        
        
        
        _choose = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30-14, (frame.size.height-14)/2, 14, 14)];
        [_choose setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [_choose setBackgroundImage:[UIImage imageNamed:@"未选中按钮"] forState:UIControlStateNormal];
        
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height, SCREEN_WIDTH, 1)];
        line.backgroundColor=RGBColor(201, 201, 201);
        
        
        
        [self addSubview:_icon];
        [self addSubview:_name];
        [self addSubview:_choose];
        [self addSubview:line];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];
        
    }
    
    return  self;
}



-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    
    self.payBlock();
}


@end
