//
//  SecurityVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SecurityVC.h"
#import "Macro.h"
#import "SetPasswordVC.h"

@implementation SecurityVC


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
    label.text=@"安全设置";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(230, 230, 230);
    [self.view addSubview:upper];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32*WIDTH_SCALE, 64+20, 100, 14)];
    label.text=@"登陆密码";
    [self.view addSubview:label];
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-32*WIDTH_SCALE-40, 64+20, 40, 14)];
    [button setTitle:@"重置" forState:UIControlStateNormal];
    [button setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *under = [[UILabel alloc]initWithFrame:CGRectMake(0, button.frame.origin.y+button.frame.size.height+20, SCREEN_WIDTH, 1)];
    under.backgroundColor=RGBColor(230, 230, 230);
    [self.view addSubview:under];
    
    
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setPassword{
    SetPasswordVC *VC = [[SetPasswordVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
