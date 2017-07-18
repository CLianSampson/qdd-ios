//
//  ChangePhoneVC.m
//  qdd
//
//  Created by sampson on 2017/7/18.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ChangePhoneVC.h"
#import "AccountCell.h"
#import "GetVerifyCodeView.h"

@interface ChangePhoneVC ()<SendSmsCodeDelegete>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)GetVerifyCodeView *verifyCode;

@end

@implementation ChangePhoneVC

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
    label.text=@"更换手机号";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    UIButton *completeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-60, 31, 60, 22)];
    [self.view addSubview:completeButton];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    completeButton.titleLabel.textAlignment=NSTextAlignmentRight;
    completeButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [completeButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self createView];
    
    
}


-(void)createView{
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+1+10, SCREEN_WIDTH, 1)];
    upper.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upper];
    
    
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(0, upper.frame.origin.y+upper.frame.size.height+1, SCREEN_WIDTH, 20+14+20)];
    background.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:background];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32*WIDTH_SCALE, upper.frame.size.height+upper.frame.origin.y+20, 100, 14)];
    label.text=@"原手机号";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGBColor(51, 51, 51);
    label.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
    UILabel *phoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-32*WIDTH_SCALE-150, upper.frame.size.height+upper.frame.origin.y+20, 40, 14)];
    phoneLabel.text = _phone;
    phoneLabel.font=[UIFont systemFontOfSize:14];
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:phoneLabel];
    
    UILabel *under = [[UILabel alloc]initWithFrame:CGRectMake(0, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+20, SCREEN_WIDTH, 1)];
    under.backgroundColor=SepreateRGBColor;
    [self.view addSubview:under];
    
    
    _verifyCode = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, under.frame.origin.y+under.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _verifyCode.delegate=self;
    _verifyCode.textField.delegate = self;

}



-(void)sendSmsCode{
//    AFNetRequest *request = [[AFNetRequest alloc]init];
//    
//    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SMS];
//    
//    
//    if (_phone.textField.text==nil
//        || [StringUtil isNullOrBlank:_phone.textField.text]) {
//        [self createAlertView];
//        self.alertView.title=@"手机号不能为空";
//        [self.alertView show];
//        
//        return;
//    }
//    
//    
//    
//    
//    NSString *urlParameters=[NSString stringWithFormat:@"mobile=%@",_phone.textField.text];
//    
//    NSString *appendUrlString=[urlstring stringByAppendingString:urlParameters];
//    
//    __weak typeof(self) weakSelf=self;
//    
//    request.netSucessBlock=^(id result){
//        NSString *state = [result objectForKey:@"state"];
//        NSString *info = [result objectForKey:@"info"];
//        
//        if ([state isEqualToString:@"success"]) {
//            
//        }else if ([state isEqualToString:@"fail"]){
//            [weakSelf createAlertView];
//            weakSelf.alertView.title=info;
//            [weakSelf.alertView show];
//            
//        }
//    };
//    
//    request.netFailedBlock=^(id result){
//        
//        [weakSelf.indicator removeFromSuperview];
//        
//        [weakSelf createAlertView];
//        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
//        [weakSelf.alertView show];
//    };
//    
//    
//    [request netRequestGetWithUrl:appendUrlString Data:nil];
}




@end
