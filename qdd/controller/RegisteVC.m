//
//  RegisteVC.m
//  qdd
//
//  Created by Apple on 17/3/8.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RegisteVC.h"
#import "Macro.h"

@interface RegisteVC()


@property(nonatomic,strong)UIButton *personal;
@property(nonatomic,strong)UIButton *enterprise;
@property(nonatomic ,strong)UIView *flagView;

@end

@implementation RegisteVC




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"注册";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self creteView];
    
}
    
    
    
-(void)creteView{
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 66+49, SCREEN_WIDTH, SCREEN_HEIGHT-66-49)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
    
    _personal = [[UIButton alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH/2, 49)];
    [_personal setTitle:@"个人账户" forState:UIControlStateNormal];
    [_personal setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    _personal.titleLabel.font=[UIFont systemFontOfSize:15];
    [_personal addTarget:self action:@selector(personalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_personal];
    
    _enterprise = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 65, SCREEN_WIDTH/2, 49)];
    [_enterprise setTitle:@"企业账号" forState:UIControlStateNormal];
    [_enterprise setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    _enterprise.titleLabel.font=[UIFont systemFontOfSize:13];
    [_enterprise addTarget:self action:@selector(enterpriseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterprise];
    
    _flagView =[[UIView alloc]initWithFrame:CGRectMake(0, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2)];
    _flagView.backgroundColor=RGBColor(0, 51, 102);
    [self.view addSubview:_flagView];
    
}


-(void)personalClick{
    [UIView animateWithDuration:0.5 animations:^{
        _flagView.frame=CGRectMake(0, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2);
    }];
     [_personal setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
       [_enterprise setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
}


-(void)enterpriseClick{
    [UIView animateWithDuration:0.5 animations:^{
        _flagView.frame=CGRectMake(SCREEN_WIDTH/2, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2);
    }];
    [_enterprise setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    [_personal setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
}


-(void)showLeft{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
