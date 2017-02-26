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
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"支付";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    [self creatView];
}


-(void)creatView{
    UILabel *background = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 24*HEIGHT_SCALE)];
    background.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:background];
    
    
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, background.frame.origin.y+background.frame.size.height, SCREEN_WIDTH, 96*HEIGHT_SCALE)];
    price.text=@"   需要支付: 123.56元 ";
    price.font=[UIFont systemFontOfSize:18];
    price.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:price];
    
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(0, price.frame.origin.y+price.frame.size.height, SCREEN_WIDTH, 89*HEIGHT_SCALE)];
    type.text=@"   选择支付方式";
    type.font=[UIFont systemFontOfSize:18];
    type.textColor=RGBColor(0, 0, 0);
    type.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:type];
    
    
    PayView *ailPay = [[PayView alloc]initWithFrame:CGRectMake(0, type.frame.origin.y+type.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    [self.view addSubview:ailPay];
    
    
    PayView *weChat = [[PayView alloc]initWithFrame:CGRectMake(0, ailPay.frame.origin.y+ailPay.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    weChat.name.text=@"微信";
    [self.view addSubview:weChat];
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, weChat.frame.origin.y+weChat.frame.size.height+178*HEIGHT_SCALE, 650*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setBackgroundColor:RGBColor(0, 54, 99)];
    confirm.titleLabel.font=[UIFont systemFontOfSize:20];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirm.layer.cornerRadius=5;
    [self.view addSubview:confirm];
    
    
    
}


-(void)confirm{
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
