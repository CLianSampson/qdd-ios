//
//  LeftVC.m
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "LeftVC.h"
#import "Macro.h"

@implementation LeftVC

//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden=NO;
//}

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
    
}

@end
