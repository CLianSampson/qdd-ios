//
//  MyOrder.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MyOrderVC.h"
#import "Macro.h"
#import "RESideMenu.h"

@implementation MyOrderVC


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
    label.text=@"我的订单";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    
    UILabel *upperLine = [[UILabel alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH,  1)];
    upperLine.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:upperLine];
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0,112, SCREEN_WIDTH,  1)];
    underLine.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:underLine];
    
    
    UIButton *allButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/3, 49)];
//    allButton.backgroundColor=[UIColor redColor];
    [allButton addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
    [allButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    
    
    UIButton *unPayButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    unPayButton.backgroundColor=[UIColor yellowColor];
    [unPayButton addTarget:self action:@selector(unPay) forControlEvents:UIControlEventTouchUpInside];
    [unPayButton setTitle:@"未支付" forState:UIControlStateNormal];
    [unPayButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    payButton.backgroundColor=[UIColor greenColor];
    [payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [payButton setTitle:@"已支付" forState:UIControlStateNormal];
    [payButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];

    
    [self.view addSubview:allButton];
    [self.view addSubview:unPayButton];
    [self.view addSubview:payButton];
    
    _underLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 113-2, SCREEN_WIDTH/3, 2)];
    _underLabel.backgroundColor=RGBColor(0 , 51, 102);
    [self.view addSubview:_underLabel];
    
    UILabel *sepreteAll = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 64+49/4, 1, 49/2)];
    sepreteAll.backgroundColor=RGBColor(241, 241, 241);
    
    
    UILabel *sepretePay = [[UILabel alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3, 64+49/4, 1, 49/2)];
    sepretePay.backgroundColor=RGBColor(241, 241, 241);
    
    [self.view addSubview:sepreteAll];
    [self.view addSubview:sepretePay];

}


-(void)all{
    [UIView animateWithDuration:0.5 animations:^{
       
        
        _underLabel.frame=CGRectMake(0, 113-2, SCREEN_WIDTH/3, 2);
    }];
}


-(void)unPay{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame= CGRectMake(SCREEN_WIDTH/3, 113-2, SCREEN_WIDTH/3, 2);

    }];
    
   }


-(void)pay{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=  CGRectMake(2*SCREEN_WIDTH/3, 113-2, SCREEN_WIDTH/3, 2);
        
    }];

    
   
}

-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}





@end
