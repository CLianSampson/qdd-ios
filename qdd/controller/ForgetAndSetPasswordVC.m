//
//  ForgetPasswordVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ForgetAndSetPasswordVC.h"
#import "Macro.h"
#import "PasswordView.h"
#import "GetVerifyCodeView.h"
#import "ResetPasswordVC.h"


@interface ForgetAndSetPasswordVC()<SendSmsCodeDelegete>

@property(nonatomic,strong)PasswordView *phone;
@property(nonatomic,strong)GetVerifyCodeView *code ;

@end

@implementation ForgetAndSetPasswordVC



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:leftButton];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"忘记密码";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    
    [self createView];
}



-(void)createView{
    [self createBackgroungView];
    
    
    UILabel *sepreate = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+20*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    sepreate.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:sepreate];

    
    
    _phone = [[PasswordView alloc]initWithFrame:CGRectMake(0, sepreate.frame.origin.y+sepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _phone.password.text=@"手机号码";
    _phone.textField.placeholder=@"请输入手机号码";
    _phone.password.textColor=RGBColor(51, 51, 51);
    _phone.textField.textColor=RGBColor(172, 172, 172);
    _phone.password.font=[UIFont systemFontOfSize:14];
    _phone.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_phone];
    
    
    _code = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, _phone.frame.origin.y+_phone.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _code.delegate=self;
    [self.view addSubview:_code];
    
    
    UIButton *nextStep = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, _code.frame.origin.y+_code.frame.size.height+150*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStep.titleLabel.font=[UIFont systemFontOfSize:18];
    //    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
    
}


-(void)showLeft{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)nextStepClick{
    if ([StringUtil isNullOrBlank:_code.textField.text]) {
        [self createAlertView];
        self.alertView.title=@"验证码不能为空";
        [self.alertView show];
        
        return;
    }
    
    ResetPasswordVC *VC =[[ResetPasswordVC alloc]init];
    VC.mobile = _phone.textField.text;
    VC.mobile_code = _code.textField.text;
    
    VC.token = self.token;
    
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)sendSmsCode{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SMS];
    
   
    if (_phone.textField.text==nil) {
        [self createAlertView];
        self.alertView.title=@"手机号不能为空";
        [self.alertView show];
        
        return;
    }

    
    
    NSString *urlParameters=[NSString stringWithFormat:@"mobile=%@",_phone.textField.text];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:urlParameters];
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
           
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    [self netRequestGetWithUrl:appendUrlString Data:nil];
}


@end
