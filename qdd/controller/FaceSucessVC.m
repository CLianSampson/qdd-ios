//
//  FaceSucessVC.m
//  qdd
//
//  Created by Apple on 17/3/13.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "FaceSucessVC.h"
#import "Macro.h"

#import "MainVC.h"
#import "RESideMenu.h"
#import "MainRigthVC.h"
#import "MainLeftVC.h"

@implementation FaceSucessVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [super createNavition];
    self.mytitle.text=@"待审核";
    
    
    UIButton *ablam = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-30*WIDTH_SCALE, 31, 60, 22)];
    [self.view addSubview:ablam];
    [ablam setTitle:@"完成" forState:UIControlStateNormal];
    ablam.titleLabel.font=[UIFont systemFontOfSize:16];
    [ablam setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ablam.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [ablam addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //    [super createBackgroungView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];
    
    
    
    [self creteView];
    
}



-(void)creteView{
    
    
    UIImageView *sucess =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60/2, 64+129*HEIGHT_SCALE, 60, 60)];
    sucess.image = [UIImage imageNamed:@"等待审核中图标"];
    [self.view addSubview:sucess];
    
    
    
    UILabel *sucessLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, sucess.frame.origin.y+sucess.frame.size.height+42*HEIGHT_SCALE, SCREEN_WIDTH, 20)];
    sucessLabel.text=@"等待审核中";
    sucessLabel.textColor=RGBColor(102, 102, 102);
    sucessLabel.font=[UIFont systemFontOfSize:20];
    sucessLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:sucessLabel];
    
    
    UILabel *failReson =[[UILabel alloc]initWithFrame:CGRectMake(0, sucessLabel.frame.origin.y+sucessLabel.frame.size.height+30*HEIGHT_SCALE, SCREEN_WIDTH, 15)];
    failReson.text=@"工作人员将在1-2日内完成审核";
    failReson.textColor=PlaceHoderRGBColor;
    failReson.font=[UIFont systemFontOfSize:15];
    failReson.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:failReson];
    
    
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-678*WIDTH_SCALE/2, failReson.frame.origin.y+failReson.frame.size.height+188*HEIGHT_SCALE, 678*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    
    //暂时设置为返回首页
//    [confirm setTitle:@"购买套餐" forState:UIControlStateNormal];
    [confirm setTitle:@"返回首页" forState:UIControlStateNormal];
    
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    confirm.layer.cornerRadius=5;
    [confirm addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
    


}




-(void)complete{
    MainVC *VC = [[MainVC alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    
    
    MainLeftVC *leftVC = [[MainLeftVC alloc] init];
    MainRigthVC *rightVC = [[MainRigthVC alloc] init];
    
    
    RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
    
    MenuVC.contentViewScaleValue=(float)305/445;
    
    
    [self presentViewController:MenuVC animated:YES completion:nil];

}

-(void)buy{
    MainVC *VC = [[MainVC alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    
    
    MainLeftVC *leftVC = [[MainLeftVC alloc] init];
    MainRigthVC *rightVC = [[MainRigthVC alloc] init];
    
    
    RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
    
    MenuVC.contentViewScaleValue=(float)305/445;
    
    
    [self presentViewController:MenuVC animated:YES completion:nil];

}

-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
