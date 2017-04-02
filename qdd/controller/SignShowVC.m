//
//  SignShowVC.m
//  qdd
//
//  Created by Apple on 17/4/2.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignShowVC.h"
#import "SignDetailVC.h"

@interface SignShowVC()

@property(nonatomic,strong)UIButton *rightButton;

@end

@implementation SignShowVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self createNavition];
    
    self.mytitle.text=_signTitle;
    
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_rightButton];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"详情按钮"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self creteView];
    
}



-(void)creteView{
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 66+49, SCREEN_WIDTH, SCREEN_HEIGHT-66-49)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
}


-(void)showRight{
    SignDetailVC *VC =[[SignDetailVC alloc]init];
    VC.signId=self.signId;
    VC.token=self.token;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
