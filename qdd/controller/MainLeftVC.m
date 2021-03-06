//
//  MainLeftVC.m
//  qdd
//
//  Created by Apple on 17/3/26.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MainLeftVC.h"
#import "Macro.h"
#import "ShoppingVC.h"
#import "MySignVC.h"
#import "ContactVC.h"
#import "MyOrderVC.h"
#import "SetVC.h"
#import "RESideMenu.h"
#import "VerifyVC.h"
#import "VerifyStateVC.h"
#import "EnterpriseVerifyVC.h"

@implementation MainLeftVC



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController.sideMenuViewController hideMenuViewController];
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=RGBColor(233 , 233, 233);
    
    //添加认证成功后的通知
    [self addNotification];
    
    float selfWidth = 445*WIDTH_SCALE;
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(selfWidth/2-77/2, 119*HEIGHT_SCALE, 77, 77)];
    [iconButton setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [iconButton addTarget:self action:@selector(goToVerifyVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconButton];
    
    
    //高度加10
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(selfWidth/2-100, iconButton.frame.origin.y+iconButton.frame.size.height+33*HEIGHT_SCALE, 200, 13)];
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self.phoneToSave];
    [mutableString insertString:@"  " atIndex:3];
    [mutableString insertString:@"  " atIndex:9];
    phoneLabel.text=mutableString;
    phoneLabel.font=[UIFont systemFontOfSize:13];
    phoneLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    
    
    UIImageView *verify = [[UIImageView alloc]initWithFrame:CGRectMake(170*WIDTH_SCALE, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+20*HEIGHT_SCALE, 14, 14)];
    if (self.verifyState == HAVE_VERIFY) {
        verify.image=[UIImage imageNamed:@"认证图标"];
    }else{
       verify.image=[UIImage imageNamed:@"未认证图标"];
    }
    
    
    [self.view addSubview:verify];
    
    //高度加10
    UILabel *verifyText = [[UILabel alloc]initWithFrame:CGRectMake((170+8)*WIDTH_SCALE+14, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+20*HEIGHT_SCALE, 200, 24*HEIGHT_SCALE)];
    verifyText.textAlignment=NSTextAlignmentLeft;
    if (self.verifyState == HAVE_VERIFY) {
        verifyText.text=@"已认证";
    }else{
        verifyText.text=@"未认证";
    }
    verifyText.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:verifyText];
    
    
    
    CGFloat y =verifyText.frame.origin.y+114*HEIGHT_SCALE;
    
    
    //以下宽度设置为300是为了居中对齐
    //暂时去掉购买套餐和我的订单
    
    UIButton *shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, y, 200*WIDTH_SCALE, 14)];
    [shoppingBtn setTitle:@"购买套餐" forState:UIControlStateNormal];
    [shoppingBtn setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    shoppingBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    shoppingBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:shoppingBtn];
    
    
    UIButton *mySignBtn = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, shoppingBtn.frame.origin.y+ shoppingBtn.frame.size.height+ 82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
    [mySignBtn setTitle:@"我的签名" forState:UIControlStateNormal];
    [mySignBtn setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    mySignBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    mySignBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:mySignBtn];
    
    
    UIButton *contactPeopel = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, mySignBtn.frame.origin.y+mySignBtn.frame.size.height+82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
    [contactPeopel setTitle:@"联系人" forState:UIControlStateNormal];
    [contactPeopel setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    contactPeopel.titleLabel.font=[UIFont systemFontOfSize:14];
    contactPeopel.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:contactPeopel];
    
    
    UIButton *myOrder = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, contactPeopel.frame.origin.y+contactPeopel.frame.size.height+82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
    [myOrder setTitle:@"我的订单" forState:UIControlStateNormal];
    [myOrder setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    myOrder.titleLabel.font=[UIFont systemFontOfSize:14];
    myOrder.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:myOrder];
    
    
    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, myOrder.frame.origin.y+myOrder.frame.size.height+82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
    [set setTitle:@"设置" forState:UIControlStateNormal];
    [set setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
    set.titleLabel.font=[UIFont systemFontOfSize:14];
    set.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:set];
    
    
    [shoppingBtn addTarget:self action:@selector(shooping) forControlEvents:UIControlEventTouchUpInside];
    [mySignBtn addTarget:self action:@selector(mySign) forControlEvents:UIControlEventTouchUpInside];
    [contactPeopel addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [myOrder addTarget:self action:@selector(myOrder) forControlEvents:UIControlEventTouchUpInside];
    [set addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
//    UIButton *mySignBtn = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, y, 200*WIDTH_SCALE, 14)];
//    [mySignBtn setTitle:@"我的签名" forState:UIControlStateNormal];
//    [mySignBtn setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
//    mySignBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    mySignBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
//    [self.view addSubview:mySignBtn];
//    
//    
//    UIButton *contactPeopel = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, mySignBtn.frame.origin.y+ mySignBtn.frame.size.height+ 82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
//    [contactPeopel setTitle:@"联系人" forState:UIControlStateNormal];
//    [contactPeopel setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
//    contactPeopel.titleLabel.font=[UIFont systemFontOfSize:14];
//    contactPeopel.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
//    [self.view addSubview:contactPeopel];
//    
//    
//    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake( (445-200)*WIDTH_SCALE/2, contactPeopel.frame.origin.y+contactPeopel.frame.size.height+82*HEIGHT_SCALE, 200*WIDTH_SCALE, 14)];
//    [set setTitle:@"设置" forState:UIControlStateNormal];
//    [set setTitleColor:RGBColor(36, 36, 36) forState:UIControlStateNormal];
//    set.titleLabel.font=[UIFont systemFontOfSize:14];
//    set.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
//    [self.view addSubview:set];
//    
//    
//    
//    [mySignBtn addTarget:self action:@selector(mySign) forControlEvents:UIControlEventTouchUpInside];
//    [contactPeopel addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
//    [set addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];

}




-(void)shooping{
    
    ShoppingVC *VC = [[ShoppingVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    VC.token = self.token;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];
}



-(void)mySign{
    
    MySignVC *VC = [[MySignVC alloc]init];
    VC.token=self.token;
    VC.VC=self.sideMenuViewController.contentViewController;
    
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];
    
    
}

-(void)contact{
    
    ContactVC *VC = [[ContactVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    
    VC.token=self.token;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];
    
}

-(void)myOrder{
    
    
    MyOrderVC *VC = [[MyOrderVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    
    VC.token=self.token;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    
    [self.sideMenuViewController hideMenuViewController];
    
}




-(void)set{
    
    
    SetVC *VC = [[SetVC alloc]init];
    VC.VC = self.sideMenuViewController.contentViewController;
    VC.token=self.token;
    VC.accountFlag=self.accountFlag;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    [self.sideMenuViewController hideMenuViewController];
    
    
    //    [self.sideMenuViewController presentViewController:nav animated:NO completion:nil];
}


-(void)goToVerifyVC{
    
    EnterpriseVerifyVC *VC =[[EnterpriseVerifyVC alloc]init];
    VC.VC=self.sideMenuViewController.contentViewController;
    
    VC.token=self.token;
    VC.authState = self.authState;
    VC.verifyState = self.verifyState;
    VC.accountFlag = self.accountFlag;
    

    //审核通过和正在审核中，暂时设置为这样
    if (self.verifyState == HAVE_VERIFY
        || self.verifyState == UNDER_VERIFYING) {
        VerifyStateVC *VC =[[VerifyStateVC alloc]init];
        VC.token = self.token;
        VC.verifyState = self.verifyState;
        VC.VC=self.sideMenuViewController.contentViewController;
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        
        [self.sideMenuViewController setContentViewController:nav];
        
        [self.sideMenuViewController hideMenuViewController];
        
        
        return;
    }
    
    
    
    if (self.accountFlag == USER_ACCOUNT) {
        VerifyVC *VC =[[VerifyVC alloc]init];
        VC.token=self.token;
        VC.VC=self.sideMenuViewController.contentViewController;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        
        [self.sideMenuViewController setContentViewController:nav];
        
        [self.sideMenuViewController hideMenuViewController];

    }else{
        EnterpriseVerifyVC *VC =[[EnterpriseVerifyVC alloc]init];
        VC.token=self.token;
        VC.VC=self.sideMenuViewController.contentViewController;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        
        [self.sideMenuViewController setContentViewController:nav];
        
        [self.sideMenuViewController hideMenuViewController];
    }
   
    
}


//添加认证通过的通知
-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaAuthState) name:@"GOTO_MAIN_CONTROLLER_FROM_ENTERPRISE_VERIFY_CONTROLLER" object:nil];
}

-(void)changeaAuthState{
    self.verifyState = UNDER_VERIFYING;
}

@end
