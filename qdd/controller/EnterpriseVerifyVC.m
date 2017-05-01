//
//  EnterpriseVerifyVC.m
//  qdd
//
//  Created by Apple on 17/5/1.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "EnterpriseVerifyVC.h"

@implementation EnterpriseVerifyVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [super createNavition];
    self.mytitle.text=@"实名认证";
    
    [super createBackgroungView];
    
    
    [self creteView];
    
}



-(void)creteView{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = GrayRGBColor;
    [self.view addSubview:upperSepreate];
    
    
    UILabel *verifyType = [[UILabel alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, 67, SCREEN_WIDTH-50*WIDTH_SCALE, 72*HEIGHT_SCALE)];
    verifyType.text = @"认证方式: 银行卡认证";
    verifyType.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:verifyType];
    
    [self createEnterpriecCertificateInformation:verifyType];
}


-(void)createEnterpriecCertificateInformation:(UIView *)view{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH, view.frame.origin.y, (38+26)*HEIGHT_SCALE + 13)];
    backGroundView.backgroundColor = GrayRGBColor;
    [self.view addSubview:backGroundView];
    
    UILabel *enterpriseInformation  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 38*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 13)];
    enterpriseInformation.text  = @"企业证件信息";
    enterpriseInformation.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:enterpriseInformation];
    
}

-(void)createEnterpriseName:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = GrayRGBColor;
    [self.view addSubview:upperSepreate];
    
    
    
}



@end
