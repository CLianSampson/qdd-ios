//
//  EnterpriseVerifyVC.m
//  qdd
//
//  Created by Apple on 17/5/1.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "EnterpriseVerifyVC.h"
#import "PasswordView.h"

@interface EnterpriseVerifyVC()

@property(nonatomic,strong)PasswordView *enterpriseName;

@end

@implementation EnterpriseVerifyVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [super createNavition];
    self.mytitle.text=@"实名认证";
    
//    [super createBackgroungView];
    
    
    [self creteView];
    
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
}


-(void)creteView{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [self.view addSubview:upperSepreate];
    
    
    UILabel *verifyType = [[UILabel alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, 67, SCREEN_WIDTH-50*WIDTH_SCALE, 72*HEIGHT_SCALE)];
    verifyType.text = @"认证方式: 银行卡认证";
    verifyType.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:verifyType];
    
    [self createEnterpriecCertificateInformation:verifyType];
}


-(void)createEnterpriecCertificateInformation:(UIView *)view{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, (38+26)*HEIGHT_SCALE + 13)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [self.view addSubview:backGroundView];
    
    UILabel *enterpriseInformation  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 38*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 13)];
    enterpriseInformation.text  = @"企业证件信息";
    enterpriseInformation.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:enterpriseInformation];
    
    [self createEnterpriseName:backGroundView];
}


-(void)createEnterpriseName:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [self.view addSubview:upperSepreate];
    
    
    _enterpriseName = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _enterpriseName.password.text=@"企业名称";
    _enterpriseName.textField.placeholder=@"请输入企业名称";
    _enterpriseName.password.textColor=RGBColor(51, 51, 51);
    _enterpriseName.textField.textColor=RGBColor(172, 172, 172);
    _enterpriseName.password.font=[UIFont systemFontOfSize:14];
    _enterpriseName.textField.font=[UIFont systemFontOfSize:14];
    [_enterpriseName addSubview:_enterpriseName.cancelButton];
    [self.view addSubview:_enterpriseName];
    
    float height = _enterpriseName.frame.origin.y + _enterpriseName.frame.size.height ;
    
    [self createReminderView:height];
    
}

-(void)createReminderView:(float )height{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, (16+26)*HEIGHT_SCALE + 10)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [self.view addSubview:backGroundView];
    
    UILabel *reminder  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 16*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 10)];
    reminder.text  = @"*   企业证件信息";
    reminder.font = [UIFont systemFontOfSize:13];
    reminder.textColor = RGBColor(255, 0, 0);
    [self.view addSubview:reminder];
    
}





@end











