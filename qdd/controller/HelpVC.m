//
//  HelpVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "HelpVC.h"
#import "Macro.h"
#import "UILabel+Adjust.h"

@interface HelpVC()

@property(nonatomic,strong)NSString *content;

@end

@implementation HelpVC

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
//    label.text=_mainTitle;
    label.text=@"帮助";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self netReauest];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, 64+62*HEIGHT_SCALE, SCREEN_WIDTH-52*2*WIDTH_SCALE, 30)];
//    label.text=@"帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助帮助";
    
    label.text=_content;
    label.textColor=RGBColor(51, 51, 51);
    label.font=[UIFont systemFontOfSize:18];
    label.numberOfLines=0;
    CGFloat height = [UILabel getHeightByWidth:label.frame.size.width title:label.text font:label.font];
    
    label.frame=CGRectMake(52*WIDTH_SCALE, 64+62*HEIGHT_SCALE, SCREEN_WIDTH-52*2*WIDTH_SCALE, height);
//    label.backgroundColor=[UIColor redColor];
    [self.view addSubview:label];
    
}

-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_HELP_DETAIL];
    
    NSString *appendUrlString = [urlstring stringByAppendingString:_helpId];
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf sucessDo:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    self.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [self netRequestGetWithUrl:appendUrlString Data:nil];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    _content = [data objectForKey:@"content"];
    
    [self createView];
}





@end
