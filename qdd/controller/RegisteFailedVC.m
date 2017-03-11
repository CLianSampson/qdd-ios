//
//  RegisteFailedVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RegisteFailedVC.h"
#import "Macro.h"

@implementation RegisteFailedVC



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
    label.text=@"注册";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    
    UIImageView *sucess =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60/2, 64+129*HEIGHT_SCALE, 60, 60)];
    sucess.image = [UIImage imageNamed:@"delete-副本"];
    [self.view addSubview:sucess];
    
    
    
    UILabel *sucessLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, sucess.frame.origin.y+sucess.frame.size.height+42*HEIGHT_SCALE, SCREEN_WIDTH, 20)];
    sucessLabel.text=@"注册失败";
    sucessLabel.textColor=RGBColor(102, 102, 102);
    sucessLabel.font=[UIFont systemFontOfSize:20];
    sucessLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:sucessLabel];
    
    
    UILabel *failReson =[[UILabel alloc]initWithFrame:CGRectMake(0, sucessLabel.frame.origin.y+sucessLabel.frame.size.height+30*HEIGHT_SCALE, SCREEN_WIDTH, 15)];
    failReson.text=@"错误原因: 手机号已被注册";
    failReson.textColor=RGBColor(255, 17, 17);
    failReson.font=[UIFont systemFontOfSize:15];
    failReson.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:failReson];

    
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-678*WIDTH_SCALE/2, failReson.frame.origin.y+failReson.frame.size.height+188*HEIGHT_SCALE, 678*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"重新注册" forState:UIControlStateNormal];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    confirm.layer.cornerRadius=5;
    [confirm addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
    
    
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
