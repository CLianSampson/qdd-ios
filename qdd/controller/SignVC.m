//
//  SignVC.m
//  qdd
//
//  Created by Apple on 17/2/26.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignVC.h"
#import "SKGraphicView.h"
#import "Macro.h"


@implementation SignVC




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"选择签章";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    
    
    UIButton *completeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-60, 31, 60, 22)];
    [self.view addSubview:completeButton];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    completeButton.titleLabel.textAlignment=UITextAlignmentRight;
    completeButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [completeButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    SKGraphicView *view = [[SKGraphicView alloc] initWithFrame:CGRectMake(30*WIDTH_SCALE, 64, SCREEN_WIDTH-60*WIDTH_SCALE, 1175*HEIGHT_SCALE)];
    view.backgroundColor = [UIColor whiteColor];
    view.color = [UIColor blackColor];
    view.lineWidth = 10;
    [self.view addSubview:view];
    
}


-(void)complete{
   
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
