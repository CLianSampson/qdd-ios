//
//  BaseVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"
#import "Macro.h"

@implementation BaseVC


-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createBackgroungView{
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
}


-(void)createAlertView{
    
    _alertView =[[UIAlertView alloc]initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    _alertView.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-30, 100, 60);
    
}

-(void)createNavition{
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_leftButton];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    _mytitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
//    _mytitle.text=@"消息";
    _mytitle.textAlignment=NSTextAlignmentCenter;
    _mytitle.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:_mytitle];

}

-(void)showLeft{
    
}


@end
