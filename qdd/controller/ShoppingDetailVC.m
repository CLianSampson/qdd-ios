//
//  ShoppingDetailVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ShoppingDetailVC.h"
#import "Macro.h"
#import "PayVC.h"


@interface ShoppingDetailVC()
{
    
    
}
@end

@implementation ShoppingDetailVC

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
    label.text=@"套餐详情";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    [self creatView];
}


-(void)creatView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,  259*HEIGHT_SCALE)];
    imageView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:imageView];
    
    
    UILabel *backGroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, SCREEN_WIDTH, 34*HEIGHT_SCALE)];
    backGroundLabel.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:backGroundLabel];
    
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, backGroundLabel.frame.origin.y+backGroundLabel.frame.size.height, 300, 13*SCALE)];
    type.text=@"套餐类型:  个人套餐A";
    type.textColor=RGBColor(51, 51, 51);
    type.font=[UIFont systemFontOfSize:19];
    [self.view addSubview:type];
    
    
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-52*WIDTH_SCALE-300, backGroundLabel.frame.origin.y+backGroundLabel.frame.size.height, 300, 13*SCALE)];
    time.text=@"有效期:  10天";
    time.textColor=RGBColor(255, 0, 0);
    time.font=[UIFont systemFontOfSize:15];
    time.textAlignment=UITextAlignmentRight;
    [self.view addSubview:time];
    
    
    UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE,time.frame.origin.y+time.frame.size.height+57*HEIGHT_SCALE , 300, 12*SCALE)];
    total.text=@"总次数:  10次";
    total.font=[UIFont systemFontOfSize:18];
    total.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:total];
    
    
    UILabel *introduction = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, total.frame.origin.y+total.frame.size.height+22*HEIGHT_SCALE, SCREEN_WIDTH-2*52*WIDTH_SCALE, 24+15*HEIGHT_SCALE)];
    introduction.text=@"购买标准化电子合同服务，该套餐可以签发合同一次，有效期为永久";
    [self.view addSubview:introduction];
    
    introduction.numberOfLines = 0; ///相当于不限制行数
    [introduction sizeToFit];

    
    
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-98*HEIGHT_SCALE, SCREEN_WIDTH, 98*HEIGHT_SCALE)];
    footLabel.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:footLabel];
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-98*HEIGHT_SCALE, 60, 98*HEIGHT_SCALE)];
    money.text=@"￥";
    money.font=[UIFont systemFontOfSize:22];
    money.textColor=RGBColor(255, 0, 0);
    money.textAlignment=UITextAlignmentRight;
    [self.view addSubview:money];
    
    UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(money.frame.size.width, SCREEN_HEIGHT-98*HEIGHT_SCALE, 60, 98*HEIGHT_SCALE)];
    number.text=@"100";
    number.font=[UIFont systemFontOfSize:28];
    number.textColor=RGBColor(255, 0, 0);
    number.textAlignment=UITextAlignmentRight;
    [self.view addSubview:number];
    
    
    UIButton *pay = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-98*HEIGHT_SCALE+(98*HEIGHT_SCALE-28)/2, 80, 28)];
    [pay setTitle:@"立即购买" forState:UIControlStateNormal];
    [pay setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    pay.titleLabel.font=[UIFont systemFontOfSize:19];
    [pay setBackgroundImage:[UIImage imageNamed:@"立即购买按钮"] forState:UIControlStateNormal];
    [self.view addSubview:pay];
    
    [pay addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)showLeft{
    //    [self.navigationController popViewControllerAnimated:YES];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)pay{
    PayVC *VC = [[PayVC alloc]init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    VC.price=0;
    [self presentViewController:VC animated:YES completion:^{
        
    }];

    
}

@end
