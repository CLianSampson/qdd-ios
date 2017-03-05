//
//  AddContactView.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AddContactView.h"
#import "Macro.h"

@implementation AddContactView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        _icon = [[UIButton alloc]initWithFrame:CGRectMake(60*WIDTH_SCALE, 42*HEIGHT_SCALE, 68, 68)];
        [_icon setBackgroundImage:[UIImage imageNamed:@"USER"] forState:UIControlStateNormal];
        [self addSubview:_icon];
        
        
        _account = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-399*WIDTH_SCALE, 44*HEIGHT_SCALE, 399*WIDTH_SCALE, 18)];
        _account.text=@"帐号  18771098004";
        _account.textColor=RGBColor(102, 102, 102);
        [self addSubview:_account];
        
        UILabel *upperLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-399*WIDTH_SCALE, 44*HEIGHT_SCALE+18+33*HEIGHT_SCALE, 399*WIDTH_SCALE, 1)];
        upperLabel.backgroundColor=RGBColor(201, 201, 201);
        [self addSubview:upperLabel];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(_account.frame.origin.x, _account.frame.origin.y+_account.frame.size.height+33*2*HEIGHT_SCALE, _account.frame.size.width, 18)];
        _name.text=@"名称  sampson chen";
        _name.textColor=RGBColor(102, 102, 102);
        [self addSubview:_name];
        
    }
    
    return self;
}


@end
