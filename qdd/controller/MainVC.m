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
    self.view.backgroundColor=RGBColor(233, 233, 233);

    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"个人"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_rightButton];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    _label.text=@"签多多";
    _label.textAlignment=UITextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:17];
    
    [self.view addSubview:_label];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 120)];
    scrollView.backgroundColor=[UIColor redColor];
    [self.view addSubview:scrollView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    button.backgroundColor=[UIColor redColor];
    [self.view addSubview:button];
    
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
