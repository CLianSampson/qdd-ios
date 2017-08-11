//
//  GetVerifyCodeView.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "GetVerifyCodeView.h"
#import "Macro.h"
#import "StringUtil.h"

@interface GetVerifyCodeView(){
}

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation GetVerifyCodeView

static int timerFlag = 60;


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel *upperlabel =[[ UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
        upperlabel.backgroundColor=RGBColor(209, 209, 209);
        [self addSubview:upperlabel];

        
        float height = self.frame.size.height;
        
        _verifyCode = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, height/2-14/2, 100, 22)];
        _verifyCode.text=@"验证码";
        _verifyCode.font=[UIFont systemFontOfSize:14];
        _verifyCode.textColor=TextRGBColor;
        [self addSubview:_verifyCode];
        
        
        //tableViewCell的默认高度是44
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(100+32*WIDTH_SCALE, (108*HEIGHT_SCALE-50)/2, 100, 50)];
        
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _textField.placeholder=@"请输入验证码";
        _textField.font=[UIFont systemFontOfSize:14];
        _textField.textColor=PlaceHoderRGBColor;
        
//            _textField.delegate=self;
        [self addSubview:_textField];
        
        _smsCode = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-(30+160)*WIDTH_SCALE, (height-56*HEIGHT_SCALE)/2, 160*WIDTH_SCALE, 56*HEIGHT_SCALE)];
//        [_smsCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//        _smsCode.titleLabel.font=[UIFont systemFontOfSize:13];
//        [_smsCode setBackgroundImage:[UIImage imageNamed:@"获取验证码按钮"] forState:UIControlStateNormal];
//        [_smsCode addTarget:self action:@selector(sendSmsCodeClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside)];
        
        [_smsCode addGestureRecognizer:labelTapGestureRecognizer];
        _smsCode.text = @"获取验证码";
        _smsCode.font = [UIFont systemFontOfSize:13];
        _smsCode.layer.cornerRadius = 5;
        _smsCode.layer.masksToBounds=YES;
        _smsCode.textAlignment = NSTextAlignmentCenter;
        _smsCode.textColor = [UIColor whiteColor];
        _smsCode.backgroundColor = BlueRGBColor;
        _smsCode.userInteractionEnabled = YES;

        
        [self addSubview:_smsCode];
        
        
        
        UILabel *underlabel =[[ UILabel alloc]initWithFrame:CGRectMake(0,height-1, SCREEN_WIDTH, 1)];
        underlabel.backgroundColor=RGBColor(209, 209, 209);
        [self addSubview:underlabel];
        
    }
    
    return  self;
}


-(void)labelTouchUpInside{
    [self sendSmsCodeClick];
}

-(void)sendSmsCodeClick{
    //以下三步，顺序不能改变
    
    [self.delegate sendSmsCode];
    
    if ([StringUtil isNullOrBlank:_phone]) {
        return;
    }
    
     _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateButtonText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}
                      
                      
-(void)updateButtonText{
    
    timerFlag--;
   
    
    NSString *string = [NSString stringWithFormat:@"%d S",timerFlag];
    
    [_smsCode setText:string];
    [_smsCode setBackgroundColor:[UIColor grayColor]];
    [_smsCode setUserInteractionEnabled:NO];
    
    if (timerFlag > 0) {
        return;
    }
    
    [_smsCode setText:@"获取验证码"];
    _smsCode.backgroundColor = BlueRGBColor;
    [_smsCode setUserInteractionEnabled:YES];
    
    
    [_timer invalidate];
    _timer = nil;
    timerFlag = 60;
    
}

@end
