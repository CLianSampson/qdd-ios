//
//  BaseVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"
#import "Macro.h"

@implementation BaseVC


-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createBackgroungView{
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
}

@end
