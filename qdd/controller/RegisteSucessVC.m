//
//  RegisteSucessVC.m
//  qdd
//
//  Created by Apple on 17/3/10.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RegisteSucessVC.h"
#import "Macro.h"
#import "LoginVC.h"

@implementation RegisteSucessVC

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
    sucess.image = [UIImage imageNamed:@"check"];
    [self.view addSubview:sucess];
    
    
    
    UILabel *sucessLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, sucess.frame.origin.y+sucess.frame.size.height+42*HEIGHT_SCALE, SCREEN_WIDTH, 20)];
    sucessLabel.text=@"注册成功";
    sucessLabel.textColor=RGBColor(102, 102, 102);
    sucessLabel.font=[UIFont systemFontOfSize:20];
    sucessLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:sucessLabel];
    
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-678*WIDTH_SCALE/2, sucessLabel.frame.origin.y+sucessLabel.frame.size.height+188*HEIGHT_SCALE, 678*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    confirm.layer.cornerRadius=5;
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];

    
}

-(void)confirm{
    LoginVC *VC = [[LoginVC alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
    
}

-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
