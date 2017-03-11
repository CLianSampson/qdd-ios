//
//  ForgetPasswordVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "Macro.h"
#import "PasswordView.h"
#import "GetVerifyCodeView.h"
#import "ResetPasswordVC.h"


@implementation ForgetPasswordVC



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

    
    
    PasswordView *phone = [[PasswordView alloc]initWithFrame:CGRectMake(0, sepreate.frame.origin.y+sepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    phone.password.text=@"手机号码";
    phone.textField.placeholder=@"请输入手机号码";
    phone.password.textColor=RGBColor(51, 51, 51);
    phone.textField.textColor=RGBColor(172, 172, 172);
    phone.password.font=[UIFont systemFontOfSize:14];
    phone.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:phone];
    
    
    GetVerifyCodeView *code = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, phone.frame.origin.y+phone.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    [self.view addSubview:code];
    
    
    UIButton *nextStep = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, code.frame.origin.y+code.frame.size.height+150*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
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
    ResetPasswordVC *VC =[[ResetPasswordVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
