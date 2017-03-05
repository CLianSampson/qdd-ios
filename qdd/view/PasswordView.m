//
//  PasswordView.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "PasswordView.h"
#import "Macro.h"

@interface PasswordView()<UITextFieldDelegate>

@end

@implementation PasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        _password =[[UILabel alloc]initWithFrame:CGRectMake(32*WIDTH_SCALE, 0, 100, 40)];
        [self addSubview:_password];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(32*WIDTH_SCALE+100, 0, SCREEN_WIDTH-32*WIDTH_SCALE-100-52*WIDTH_SCALE-14, 40)];
        _textField.placeholder=@"请输入原始密码";
        _textField.delegate=self;
        [self addSubview:_textField];
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-52*WIDTH_SCALE-14, (40-14)/2, 14, 14)];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"删除密码"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_cancelButton];
        
        UILabel *under =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 1)];
        under.backgroundColor=RGBColor(200 , 200, 200);
        [self addSubview:under];
        
    }
    
    return self;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addSubview:_cancelButton];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_cancelButton removeFromSuperview];
    
    return YES;
}


-(void)cancel{
    _textField.text=nil;
}


@end
