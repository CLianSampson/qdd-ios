//
//  MessageDetailVC.m
//  qdd
//
//  Created by Apple on 17/2/21.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MessageDetailVC.h"
#import "Macro.h"
#import "MessageDetailView.h"
#import "UILabel+Adjust.h"
#import "AFNetRequest.h"


@interface MessageDetailVC()

@end

@implementation MessageDetailVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [super createNavition];
    
    self.mytitle.text=@"消息详情";
    

    [self addLoadIndicator];
    [self netReauest];
    
}



-(void)createView{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];
    
    UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 66+90*HEIGHT_SCALE, 32, 32)];
    icon.image=[UIImage imageNamed:@"消息图标详情"];
    [self.view addSubview:icon];
    
    
    
    MessageDetailView *message = [[MessageDetailView alloc]init];
    message.backgroundColor=RGBColor(235, 239, 242);
    message.frame=CGRectMake(icon.frame.origin.x+icon.frame.size.width+26*WIDTH_SCALE, 66+90*HEIGHT_SCALE, 600*WIDTH_SCALE, 383*HEIGHT_SCALE);
    
    
    
    message.mainTitle.frame=CGRectMake(40*WIDTH_SCALE, 46*HEIGHT_SCALE, 600*WIDTH_SCALE, 16);
    message.mainTitle.text=_mainTitle;
    
    
    
    
    message.sepreate.frame=CGRectMake(40*WIDTH_SCALE, message.mainTitle.frame.origin.y+message.mainTitle.frame.size.height+24*HEIGHT_SCALE+1, 600*WIDTH_SCALE-2*40*WIDTH_SCALE, 1);
    message.sepreate.backgroundColor=SepreateRGBColor;
    
    
    

    message.subTitle.frame=CGRectMake(40*WIDTH_SCALE, message.sepreate.frame.origin.y+message.frame.size.height+24*HEIGHT_SCALE ,600*WIDTH_SCALE-2*40*WIDTH_SCALE, 100);
    message.subTitle.text=_subTitle;
    
    message.subTitle.numberOfLines=0;
    //动态获取subtitle的高度
    float subTitleHeight = [UILabel getHeightByWidth:message.subTitle.frame.size.width title:message.subTitle.text font:message.subTitle.font];
    
    
    NSLog(@"%f",subTitleHeight);
    
    message.subTitle.frame=CGRectMake(40*WIDTH_SCALE, message.sepreate.frame.origin.y+message.sepreate.frame.size.height+24*HEIGHT_SCALE ,600*WIDTH_SCALE-2*40*WIDTH_SCALE, subTitleHeight);
   
    
    
    
    float messageHeight = (46+24+24+40)*HEIGHT_SCALE + 16 + subTitleHeight;
    
    message.frame=CGRectMake(icon.frame.origin.x+icon.frame.size.width+26*WIDTH_SCALE, 66+90*HEIGHT_SCALE, 600*WIDTH_SCALE, messageHeight);
    
    
    [self.view addSubview:message];

    
    [message addSubview:message.mainTitle];
    [message addSubview:message.subTitle];
    [message addSubview:message.sepreate];
    
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
    self.backBlock();
}



-(void)netReauest{
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_MESSAGE_DETAIL];
    [urlstring appendString:self.token];
    
    NSString *statusString = [NSString stringWithFormat:@"/id/%@",_messageId];
   
    [urlstring appendString:statusString];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
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
    
    request.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestGetWithUrl:urlstring Data:nil];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    
    _mainTitle = [data objectForKey:@"title"];
    _subTitle = [data objectForKey:@"contents"];
    
   
    [self createView];
}


@end
