//
//  ForgetPasswordVC.m
//  qdd
//
//  Created by sampson on 2017/8/13.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "PasswordView.h"
#import "RegisteCell.h"
#import "UILabel+Adjust.h"

#import "ForgetAndSetPasswordVC.h"


@interface ForgetPasswordVC(){
}

@property(nonatomic,strong)PasswordView* phone;

@property(nonatomic,strong)UIImage *verifyCodeImage;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)UIButton *verfyCode;

@end

@implementation ForgetPasswordVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"忘记密码";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    [self createView];
}

-(void)showLeft{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)createView{
    UIView *sepreate = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 10)];
    sepreate.backgroundColor = RGBColor(241, 241, 241);;
    [self.view addSubview:sepreate];
    
    _phone = [[PasswordView alloc]initWithFrame:CGRectMake(0, sepreate.frame.origin.y+sepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _phone.password.text=@"账 号";
    _phone.textField.placeholder=@"请输入手机号码或邮箱";
    _phone.password.textColor=RGBColor(51, 51, 51);
    _phone.textField.textColor=RGBColor(172, 172, 172);
    _phone.password.font=[UIFont systemFontOfSize:14];
    _phone.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_phone];
    
    
    
    UIView *backGround = [[UIView alloc]initWithFrame:CGRectMake(0,_phone.frame.origin.y+_phone.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    backGround.userInteractionEnabled  = YES;
    [self.view addSubview:backGround];

    UILabel *label = [[UILabel alloc]init];
    label = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 0, 60, 108*HEIGHT_SCALE)];
    label.text = @"验证码";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGBColor(51, 51, 51);
    [backGround addSubview:label];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(32*WIDTH_SCALE+100, 0, SCREEN_WIDTH-32*WIDTH_SCALE-100-52*WIDTH_SCALE-14, 108*HEIGHT_SCALE)];
    _textField.textAlignment=NSTextAlignmentLeft;
    _textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _textField.placeholder = @"请输入验证码";
    _textField.font = [UIFont systemFontOfSize:14];
    
    [backGround addSubview:_textField];
    
    
    UILabel  *_change = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20*WIDTH_SCALE, 65*HEIGHT_SCALE, 60, 50-(56)*HEIGHT_SCALE)];
    _change.text=@"看不清，换一张";
    _change.font=[UIFont systemFontOfSize:11];
    _change.textColor=RGBColor(178, 178, 178);
    _change.numberOfLines=0;
    CGFloat width = [UILabel getWidthWithTitle:_change.text font:_change.font];
    _change.frame=CGRectMake(SCREEN_WIDTH-20*WIDTH_SCALE-width, 40*HEIGHT_SCALE, width, 50-(65)*HEIGHT_SCALE);
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendPictureCode)];
    [_change addGestureRecognizer:gesture];
    _change.userInteractionEnabled  = YES;

    [backGround addSubview:_change];
    
    _verfyCode  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-_change.frame.size.width-(20+14+120)*WIDTH_SCALE, 27*HEIGHT_SCALE, 120*WIDTH_SCALE, 50-(22+27)*HEIGHT_SCALE)];
    [_verfyCode setTitle:@"验证码" forState:UIControlStateNormal];
    [_verfyCode addTarget:self action:@selector(sendPictureCode) forControlEvents:UIControlEventTouchUpInside];
    [backGround addSubview:_verfyCode];
    
    //发送图片验证码
    [self sendPictureCode];
    
    
    UILabel *under =[[UILabel alloc]initWithFrame:CGRectMake(0, backGround.frame.origin.y+backGround.frame.size.height, SCREEN_WIDTH, 1)];
    under.backgroundColor=RGBColor(200 , 200, 200);
    [self.view addSubview:under];
    
    
    
    UIButton *nextStep = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, under.frame.origin.y+under.frame.size.height+150*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStep.titleLabel.font=[UIFont systemFontOfSize:18];
    //    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];

}


-(void)sendPictureCode{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    __weak typeof(self) weakSelf=self;
    
    request.pictureBlock=^(id result){
        
        weakSelf.verifyCodeImage =[UIImage imageWithData:result];
//        [_cell.verfyCode setBackgroundImage:_verifyCodeImage forState:UIControlStateNormal];
        [_verfyCode setBackgroundImage:_verifyCodeImage forState:UIControlStateNormal];
    };
    
    [request downLoad:URL_PICTURE_CODE];
}




-(void)nextStepClick{
    if ([StringUtil isNullOrBlank:_textField.text]
        || [StringUtil isNullOrBlank:_phone.textField.text]) {
        [self createAlertView];
        self.alertView.title=@"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    [self netRequest];
    
//    ResetPasswordVC *VC =[[ResetPasswordVC alloc]init];
//    VC.mobile = _phone.textField.text;
//    VC.mobile_code = _code.textField.text;
//    
//    VC.token = self.token;
//    
//    [self.navigationController pushViewController:VC animated:YES];
}

-(void)netRequest{
    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    request.context = self;
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_FORGET_PASSWORD_NEW];
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:_phone.textField.text forKey:@"email"];
    [dic setObject:_textField.text forKey:@"verify"];

    NSLog(@"忘记密码第一步参数: %@",dic);
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            if ([info isEqualToString:@"验证成功"]) {
                ForgetAndSetPasswordVC *VC = [[ForgetAndSetPasswordVC alloc]init];
                VC.mobile = _phone.textField.text;
                VC.verifyCode = _textField.text;
                
                [self.navigationController pushViewController:VC animated:YES];
                
                
            }else{
                //邮箱
                [weakSelf createAlertView];
                weakSelf.alertView.title=info;
                [weakSelf.alertView show];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
    };
    
    request.netFailedBlock=^(id result){
        
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    NSLog(@"忘记密码第一步 : %@" ,urlstring);
    [request netRequestWithUrl:urlstring Data:dic];
}




@end





