//
//  SignSucessVC.m
//  qdd
//
//  Created by Apple on 17/4/17.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignSucessVC.h"
#import "Constants.h"

@implementation SignSucessVC

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
    label.text=@"签署完成";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    
    [self createView];
}

-(void)createView{
    [self createBackgroungView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *sucess =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60/2, 64+129*HEIGHT_SCALE, 60, 60)];
    sucess.image = [UIImage imageNamed:@"check"];
    [self.view addSubview:sucess];
    
    
    
    UILabel *sucessLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, sucess.frame.origin.y+sucess.frame.size.height+42*HEIGHT_SCALE, SCREEN_WIDTH, 20)];
    sucessLabel.text=@"合同签署完成";
    sucessLabel.textColor=RGBColor(102, 102, 102);
    sucessLabel.font=[UIFont systemFontOfSize:20];
    sucessLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:sucessLabel];
    
    
    UILabel *failReson =[[UILabel alloc]initWithFrame:CGRectMake(0, sucessLabel.frame.origin.y+sucessLabel.frame.size.height+30*HEIGHT_SCALE, SCREEN_WIDTH, 15)];
    NSMutableString *string = [[NSMutableString alloc]initWithString:@"您的套餐剩余次数"];
    [string appendString:[(NSNumber *)_mealTimes stringValue]];
    
    failReson.text=string;
    failReson.textColor=PlaceHoderRGBColor;
    failReson.font=[UIFont systemFontOfSize:15];
    failReson.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:failReson];

    
    
    UIButton *goBack = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, failReson.frame.origin.y+190*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [goBack setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [goBack setTitle:@"返回首页" forState:UIControlStateNormal];
    [goBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goBack.titleLabel.font=[UIFont systemFontOfSize:18];
    [goBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBack];
    
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:GOTO_MAIN_CONTROLLER_FROM_SIGN_SUCESS_CONTROLLER object:nil];
}




@end
