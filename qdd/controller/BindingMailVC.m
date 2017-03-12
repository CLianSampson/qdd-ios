//
//  BindingMailVC.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "BindingMailVC.h"
#import "Macro.h"
#import "AccountCell.h"
#import "UILabel+Adjust.h"
#import "BindMailVC.h"

@interface BindingMailVC()

@property(nonatomic,strong)UITextField *textField;

@end

@implementation BindingMailVC

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
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    UIButton  *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-30*WIDTH_SCALE, 31, 40, 22)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];

    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+16*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    underLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underLine];
    
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, underLine.frame.origin.y+underLine.frame.size.height+1, SCREEN_WIDTH, 107*HEIGHT_SCALE)];
    label.text=@"    邮箱地址";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGBColor(51, 51, 51);
    float width =[UILabel getWidthWithTitle:label.text font:label.font];
    label.frame=CGRectMake(0, underLine.frame.origin.y+underLine.frame.size.height+1, width, 107*HEIGHT_SCALE);
    label.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width, underLine.frame.origin.y+underLine.frame.size.height+1, SCREEN_WIDTH-label.frame.size.width-label.frame.origin.x, 107*HEIGHT_SCALE)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    _textField =[[UITextField alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width, underLine.frame.origin.y+underLine.frame.size.height+1, SCREEN_WIDTH-label.frame.size.width-label.frame.origin.x-32*WIDTH_SCALE, 107*HEIGHT_SCALE)];
    _textField.placeholder=@"请输入邮箱地址";
    _textField.font=[UIFont systemFontOfSize:14];
    _textField.textColor=PlaceHoderRGBColor;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:_textField];
    
    UILabel *underSepreate = [[UILabel alloc]initWithFrame:CGRectMake(0, _textField.frame.origin.y+_textField.frame.size.height+1, SCREEN_WIDTH, 1)];
    underSepreate.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underSepreate];
    
    
}


-(void)complete{
    [super createAlertView];
    
    if ([_textField.text isEqualToString:@""]) {
        self.alertView.title=@"邮箱地址不能为空";
        [self.alertView show];
        return;
    }
    
    BindMailVC *VC =[[BindMailVC alloc]init];
    VC.mailAccount=_textField.text;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
