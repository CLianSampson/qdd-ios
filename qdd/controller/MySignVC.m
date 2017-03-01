//
//  MySignVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MySignVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "SignVC.h"
#import "SignImageView.h"

@implementation MySignVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
   
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"我的签名";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-100, 31, 100, 22)];
    [self.view addSubview:addButton];
    [addButton setTitle:@"添加签章" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addButton.titleLabel.textAlignment=UITextAlignmentRight;
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *backGround = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    backGround.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backGround];
    
    //按22号字体算
    UILabel *personSign = [[UILabel alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, backGround.frame.origin.y+backGround.frame.size.height+28*HEIGHT_SCALE, SCREEN_WIDTH-42*WIDTH_SCALE, 29)];
    
    personSign.text=@"个人签章";
    personSign.font=[UIFont systemFontOfSize:22];
    [self.view addSubview:personSign];
    
    SignImageView *signImageView = [[SignImageView alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, personSign.frame.origin.y+personSign.frame.size.height+28*HEIGHT_SCALE, 665*WIDTH_SCALE, 285*HEIGHT_SCALE)];
    signImageView.image =[UIImage imageNamed:@""];
    signImageView.backgroundColor=[UIColor redColor];
    [self.view addSubview:signImageView];
    
}


-(void)add{
    SignVC *vc = [[SignVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}






@end
