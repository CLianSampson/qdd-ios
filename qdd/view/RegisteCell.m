//
//  RegisteCell.m
//  qdd
//
//  Created by Apple on 17/3/9.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RegisteCell.h"
#import "Macro.h"
#import "UILabel+Adjust.h"

@interface RegisteCell()<UITextFieldDelegate>

@end

@implementation RegisteCell

//cell高度为60
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 14, 22, 22)];
        [self addSubview:_icon];
        
        
        //tableViewCell的默认高度是44
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(_icon.frame.origin.x+_icon.frame.size.width+44*WIDTH_SCALE, 0, self.frame.size.width-(_icon.frame.origin.x+_icon.frame.size.width+44*WIDTH_SCALE), 50)];
        
        
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        
        _textField.delegate=self;
        [self addSubview:_textField];
        
        _smsCode = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(30+160)*WIDTH_SCALE, (50-56*HEIGHT_SCALE)/2, 160*WIDTH_SCALE, 56*HEIGHT_SCALE)];
        [_smsCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _smsCode.titleLabel.font=[UIFont systemFontOfSize:13];
        [_smsCode setBackgroundImage:[UIImage imageNamed:@"获取验证码按钮"] forState:UIControlStateNormal];
        [_smsCode addTarget:self action:@selector(smsCodeClick) forControlEvents:UIControlEventTouchUpInside];
        
        _change = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20*WIDTH_SCALE, 65*HEIGHT_SCALE, 60, 50-(56)*HEIGHT_SCALE)];
        _change.text=@"看不清，换一张";
        _change.font=[UIFont systemFontOfSize:11];
        _change.textColor=RGBColor(178, 178, 178);
        _change.numberOfLines=0;
        CGFloat width = [UILabel getWidthWithTitle:_change.text font:_change.font];
        _change.frame=CGRectMake(SCREEN_WIDTH-20*WIDTH_SCALE-width, 40*HEIGHT_SCALE, width, 50-(65)*HEIGHT_SCALE);
      
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picrureCode)];
        [_change addGestureRecognizer:gesture];
        _change.userInteractionEnabled  = YES;

        
        
//        [self addTap:_verfyCode];
        
        _verfyCode  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-_change.frame.size.width-(20+14+120)*WIDTH_SCALE, 27*HEIGHT_SCALE, 120*WIDTH_SCALE, 50-(22+27)*HEIGHT_SCALE)];
//        _verfyCode.backgroundColor=[UIColor yellowColor];
        [_verfyCode setTitle:@"验证码" forState:UIControlStateNormal];
        [_verfyCode addTarget:self action:@selector(picrureCode) forControlEvents:UIControlEventTouchUpInside];
               
    }
    
    return self;
}



//textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _value = textField.text;
}


-(void)smsCodeClick{
    _smsCodeBlock();
}


-(void)addTap:(UIView *)view{
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(picrureCode)];
    
    [view addGestureRecognizer:tapGesture];
}

-(void)picrureCode{
    _pictureCodeBlock();
}



@end
