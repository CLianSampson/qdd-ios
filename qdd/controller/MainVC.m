//
//  MainVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "MainVC.h"
#import "AFNetRequest.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "RightVC.h"

@implementation MainVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"个人"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:rightButton];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"签多多";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    
    [self.view addSubview:label];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 120)];
    scrollView.backgroundColor=[UIColor redColor];
    [self.view addSubview:scrollView];
    
}



-(void)showLeft{
    [self presentLeftMenuViewController:nil];
}


-(void)showRight{
    RightVC *vc = [[RightVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)click{
    NSLog(@"button click sucess");
    self.block(@"chenlian");
    AFNetRequest *request = [[AFNetRequest alloc]init];
    [request getMethod];
}

@end
