//
//  CommentVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "CommentVC.h"
#import "Macro.h"

@implementation CommentVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    
    UIButton  *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-30*WIDTH_SCALE, 31, 40, 22)];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"意见反馈";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
   
    
    [self creatView];
    
}



-(void)creatView{
    [super createBackgroungView];
    
    UILabel *choose =[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 65+15, SCREEN_WIDTH, 17)];
    choose.text=@"请选择问题类型";
    [self.view addSubview:choose];
    
    
    float width = (SCREEN_WIDTH-2*49*WIDTH_SCALE-38*3*WIDTH_SCALE)/3;
    
    
//    UIButton *defaultButton = [UIButton alloc]initWithFrame:CGRectMake(49*WIDTH_SCALE, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commit{

}


@end
