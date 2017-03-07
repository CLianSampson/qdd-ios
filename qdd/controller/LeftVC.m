//
//  LeftVC.m
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "LeftVC.h"
#import "Macro.h"
#import "ShoppingVC.h"
#import "MySignVC.h"
#import "ContactVC.h"
#import "MyOrderVC.h"
#import "SetVC.h"
#import "RESideMenu.h"

@interface LeftVC ()
{
    
    
}

@end


@implementation LeftVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController.sideMenuViewController hideMenuViewController];
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=RGBColor(150 , 150, 150);
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(145*WIDTH_SCALE, 119*HEIGHT_SCALE, 77, 77)];
    [iconButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [self.view addSubview:iconButton];
    
    
    //高度加10
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(132*WIDTH_SCALE, 77+(119+33)*HEIGHT_SCALE, 200, 26*HEIGHT_SCALE+10*HEIGHT_SCALE)];
    phoneLabel.text=@"136 6666 6666";
    phoneLabel.font=[UIFont systemFontOfSize:20];
    phoneLabel.textAlignment=UITextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    
    UIImageView *verify = [[UIImageView alloc]initWithFrame:CGRectMake(170*WIDTH_SCALE, 77+(119+33+26+20)*HEIGHT_SCALE, 14, 14)];
    verify.image=[UIImage imageNamed:@"认证图标"];
    [self.view addSubview:verify];
    
     //高度加10
    UILabel *verifyText = [[UILabel alloc]initWithFrame:CGRectMake((170+8)*WIDTH_SCALE+14, 77+(119+33+26+20+10)*HEIGHT_SCALE, 200, 24*HEIGHT_SCALE)];
    verifyText.textAlignment=UITextAlignmentLeft;
    verifyText.text=@"已认证";
    [self.view addSubview:verifyText];
    
    NSLog(@"****************** %f",verifyText.frame.origin.y);
    NSLog(@"%f",445*SCREEN_WIDTH);
    
    CGFloat y =verifyText.frame.origin.y;
    
    
    //以下宽度设置为300是为了居中对齐
    UIButton *shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, y+114*HEIGHT_SCALE, 300*WIDTH_SCALE, 75*HEIGHT_SCALE)];
    [shoppingBtn setTitle:@"购买套餐" forState:UIControlStateNormal];
    [shoppingBtn setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    [self.view addSubview:shoppingBtn];
    
    
    UIButton *mySignBtn = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, shoppingBtn.frame.origin.y+(75+82)*HEIGHT_SCALE, 300*WIDTH_SCALE, 75*HEIGHT_SCALE)];
    [mySignBtn setTitle:@"我的签名" forState:UIControlStateNormal];
    [mySignBtn setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    [self.view addSubview:mySignBtn];

    
    UIButton *contactPeopel = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, mySignBtn.frame.origin.y+(75+82)*HEIGHT_SCALE, 300*WIDTH_SCALE, 75*HEIGHT_SCALE)];
    [contactPeopel setTitle:@"联系人" forState:UIControlStateNormal];
    [contactPeopel setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    [self.view addSubview:contactPeopel];
    
    
    UIButton *myOrder = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, contactPeopel.frame.origin.y+(75+82)*HEIGHT_SCALE, 300*WIDTH_SCALE, 75*HEIGHT_SCALE)];
    [myOrder setTitle:@"我的订单" forState:UIControlStateNormal];
    [myOrder setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    [self.view addSubview:myOrder];
    
    
    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, myOrder.frame.origin.y+(75+82)*HEIGHT_SCALE, 300*WIDTH_SCALE, 75*HEIGHT_SCALE)];
    [set setTitle:@"设置" forState:UIControlStateNormal];
    [set setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    [self.view addSubview:set];
    
    
    [shoppingBtn addTarget:self action:@selector(shooping) forControlEvents:UIControlEventTouchUpInside];
    [mySignBtn addTarget:self action:@selector(mySign) forControlEvents:UIControlEventTouchUpInside];
    [contactPeopel addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [myOrder addTarget:self action:@selector(myOrder) forControlEvents:UIControlEventTouchUpInside];
    [set addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];


}

-(void)shooping{
   
    ShoppingVC *VC = [[ShoppingVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;

    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
     [self.sideMenuViewController hideMenuViewController];
}



-(void)mySign{
    
    MySignVC *VC = [[MySignVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
   
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];


}

-(void)contact{
    
    ContactVC *VC = [[ContactVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];

}

-(void)myOrder{
    
    
    MyOrderVC *VC = [[MyOrderVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];


}


-(void)set{

    
    SetVC *VC = [[SetVC alloc]init];
    VC.VC = self.sideMenuViewController.contentViewController;
//     VC.VC=self.sideMenuViewController;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    [self.sideMenuViewController hideMenuViewController];
    
    
    
}

@end
