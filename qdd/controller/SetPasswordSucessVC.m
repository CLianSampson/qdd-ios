//
//  SetPasswordSucessVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SetPasswordSucessVC.h"
#import "Macro.h"
#import "LoginVC.h"

@implementation SetPasswordSucessVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"密码找回";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    
    [self createView];
}

-(void)createView{
    [self createBackgroungView];
    
    
    UILabel *remind = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+140*HEIGHT_SCALE, SCREEN_WIDTH, 13)];
    remind.text=@"密码找回成功，请重新登陆。";
    remind.textColor=GrayRGBColor;
    remind.font=[UIFont systemFontOfSize:13];
    remind.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:remind];
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, remind.frame.origin.y+190*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [login setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [login setTitle:@"登陆" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:18];
    //    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)login{
    LoginVC *VC = [[LoginVC alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}




@end
