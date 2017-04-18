//
//  AddSignatureVC.m
//  qdd
//
//  Created by Apple on 17/4/18.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AddSignatureVC.h"

#import "SKGraphicView.h"
#import "Macro.h"

@interface AddSignatureVC()

@property(nonatomic,strong)SKGraphicView *drawView;

@end

@implementation AddSignatureVC




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"选择签章";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    UIButton *completeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-60, 31, 60, 22)];
    [self.view addSubview:completeButton];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    completeButton.titleLabel.textAlignment=NSTextAlignmentRight;
    completeButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [completeButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    _drawView = [[SKGraphicView alloc] initWithFrame:CGRectMake(30*WIDTH_SCALE, 64, SCREEN_WIDTH-60*WIDTH_SCALE, 1175*HEIGHT_SCALE)];
    _drawView.backgroundColor = [UIColor whiteColor];
    _drawView.color = [UIColor blackColor];
    _drawView.lineWidth = 10;
    [self.view addSubview:_drawView];
    
}


-(void)complete{
    [self netReauest];
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


//上传图片获取图片路径
-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_UPLOAD_PICTURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSLog(@"appendUrlString is : %@",appendUrlString);
    
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
    
    [self upLoad:appendUrlString image:_drawView.getDrawingImg];
}


-(void)sucessDo:(id )result{
    
    [self createAlertView];
    self.alertView.title=@"上传图片成功";
    [self.alertView show];
    return;
    
}


//上传签名
-(void)uploadSignature:(NSString *)path{
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_UPLOAD_PICTURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSLog(@"appendUrlString is : %@",appendUrlString);
    
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
    
    [self upLoad:appendUrlString image:_drawView.getDrawingImg];

}


@end
