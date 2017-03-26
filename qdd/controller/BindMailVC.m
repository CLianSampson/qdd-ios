//
//  BindMailVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "BindMailVC.h"
#import "Macro.h"
#import "MainVC.h"
#import "RESideMenu.h"
#import "LeftVC.h"
#import "MainRigthVC.h"

@implementation BindMailVC


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
    label.text=@"绑定邮箱";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    
    [self createView];
}





-(void)createView{
    [self createBackgroungView];
    
    
    UILabel *haveSend = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+120*HEIGHT_SCALE, SCREEN_WIDTH, 14)];
    haveSend.text=@"激活邮件已发送到:";
    haveSend.textColor=GrayRGBColor;
    haveSend.font=[UIFont systemFontOfSize:14];
    haveSend.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:haveSend];
    
    UILabel *mail =[[UILabel alloc ]initWithFrame:CGRectMake(0, haveSend.frame.origin.y+haveSend.frame.size.height+20*HEIGHT_SCALE, SCREEN_WIDTH/2, 14)];
    mail.text=_mailAccount;
    mail.font=[UIFont systemFontOfSize:14];
    mail.textColor=GrayRGBColor;
    mail.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:mail];
    
    
    

    UIButton *active = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,haveSend.frame.origin.y+haveSend.frame.size.height+20*HEIGHT_SCALE, SCREEN_WIDTH/2, 14)];
    [active setTitle:@",  点击前去激活" forState:UIControlStateNormal];
    [active setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    active.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    active.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:active];
    
    
    
    
    
    
    
    UILabel *noMail =[[UILabel alloc ]initWithFrame:CGRectMake(0, mail.frame.origin.y+mail.frame.size.height+80*HEIGHT_SCALE, SCREEN_WIDTH/2+20, 14)];
    noMail.text=@"没收到激活邮件？";
    noMail.font=[UIFont systemFontOfSize:14];
    noMail.textColor=GrayRGBColor;
    noMail.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:noMail];
    
    
    
    
    UIButton *reSend = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+20,mail.frame.origin.y+mail.frame.size.height+80*HEIGHT_SCALE, SCREEN_WIDTH/2-20, 14)];
    [reSend setTitle:@"  重新发送" forState:UIControlStateNormal];
    [reSend setTitleColor:RedRGBColor forState:UIControlStateNormal];
    reSend.titleLabel.font=[UIFont systemFontOfSize:14];
    reSend.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:reSend];
    

    
    
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-678*WIDTH_SCALE/2, reSend.frame.origin.y+reSend.frame.size.height+200*HEIGHT_SCALE, 678*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"返回首页" forState:UIControlStateNormal];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    confirm.layer.cornerRadius=5;
    [confirm addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];

}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToHome{
    MainVC *VC = [[MainVC alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];


    LeftVC *leftVC = [[LeftVC alloc] init];
    MainRigthVC *rightVC = [[MainRigthVC alloc] init];


     RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
     MenuVC.contentViewScaleValue=0.69;
    
    
    [self presentViewController:MenuVC animated:YES completion:nil];
}

@end
