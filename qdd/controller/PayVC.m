//
//  PayVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "PayVC.h"
#import "Macro.h"
#import "PayView.h"

@implementation PayVC


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
    label.text=@"支付";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    [self creatView];
}


-(void)creatView{
    UILabel *upperLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upperLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upperLine];
    
    UILabel *background = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+2, SCREEN_WIDTH, 24*HEIGHT_SCALE)];
    background.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:background];
    
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0, background.frame.origin.y+background.frame.size.height+1, SCREEN_WIDTH, 1)];
    underLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underLine];
    
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, background.frame.origin.y+background.frame.size.height, SCREEN_WIDTH, 96*HEIGHT_SCALE)];
    price.text=@"   需要支付: 123.56元 ";
    price.font=[UIFont systemFontOfSize:14];
    price.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:price];
    
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(0, price.frame.origin.y+price.frame.size.height, SCREEN_WIDTH, 89*HEIGHT_SCALE)];
    type.text=@"   选择支付方式";
    type.font=[UIFont systemFontOfSize:14];
    type.textColor=RGBColor(0, 0, 0);
    type.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:type];
    
    
    PayView *ailPay = [[PayView alloc]initWithFrame:CGRectMake(0, type.frame.origin.y+type.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    [ailPay.icon setImage:[UIImage imageNamed:@"支付宝图标"]];
    ailPay.name.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:ailPay];
   
    
    
    PayView *weChat = [[PayView alloc]initWithFrame:CGRectMake(0, ailPay.frame.origin.y+ailPay.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    weChat.name.text=@"微信";
     [weChat.icon setImage:[UIImage imageNamed:@"微信图标"]];
    weChat.name.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:weChat];
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, weChat.frame.origin.y+weChat.frame.size.height+178*HEIGHT_SCALE, 650*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setBackgroundColor:RGBColor(0, 54, 99)];
    confirm.titleLabel.font=[UIFont systemFontOfSize:17];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirm.layer.cornerRadius=5;
    [self.view addSubview:confirm];
    
    
    
}


-(void)confirm{
    [super createAlertView];
    self.alertView.title=@"您已成功支付123.56元";
    [self.alertView show];
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
