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
#import "PasswordView.h"


@interface ChangePhoneVC ()<SendSmsCodeDelegete>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)GetVerifyCodeView *verifyCode;
@property(nonatomic,strong)PasswordView *phoneInput;

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
    [self createBackgroungView];
    
    
    UILabel *sepreate = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+20*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    sepreate.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:sepreate];
    
    
    
    _phoneInput = [[PasswordView alloc]initWithFrame:CGRectMake(0, sepreate.frame.origin.y+sepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _phoneInput.password.text=@"手机号码";
    _phoneInput.textField.placeholder=@"请输入手机号码";
    _phoneInput.password.textColor=RGBColor(51, 51, 51);
    _phoneInput.textField.textColor=RGBColor(172, 172, 172);
    _phoneInput.password.font=[UIFont systemFontOfSize:14];
    _phoneInput.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_phoneInput];
    
    
    _verifyCode = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, _phoneInput.frame.origin.y+_phoneInput.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _verifyCode.delegate=self;
    [self.view addSubview:_verifyCode];
    

}

-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)sendSmsCode{
    
    _verifyCode.phone = _phoneInput.textField.text;
    
    if ([StringUtil isNullOrBlank:_phoneInput.textField.text]) {
        [self createAlertView];
        self.alertView.title=@"手机号不能为空";
        [self.alertView show];
        
        return;
    }

    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SMS];
    
    NSString *urlParameters=[NSString stringWithFormat:@"mobile=%@",_phoneInput.textField.text];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:urlParameters];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
        }else if ([state isEqualToString:@"fail"]){
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
    
    
    [request netRequestGetWithUrl:appendUrlString Data:nil];
}



-(void)complete{
    if (self.token==nil) {
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    request.context = self;
    
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_CHANGE_PHONE];
    [urlstring appendString:self.token];
    
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:_verifyCode.textField.text forKey:@"mobile_code"];
    [dic setObject:_phoneInput.textField.text forKey:@"mobile"];
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
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
    
    NSLog(@"修改手机号码 url : %@",urlstring);
    NSLog(@"修改手机号码 dic : %@",dic);
    [request netRequestWithUrl:urlstring Data:dic];
}


@end
