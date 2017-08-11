//
//  SetPasswordVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SetPasswordVC.h"
#import "Macro.h"
#import "PasswordView.h"
#import "SaveToMemory.h"
#import "LoginVC.h"
#import "Constants.h"
#import "AFNetRequest.h"


@interface SetPasswordVC()

@property(nonatomic,strong)UILabel *accountLabel;

@property(nonatomic,strong)PasswordView *oldPassword;

@property(nonatomic,strong)PasswordView *newingPassword;

@property(nonatomic,strong)PasswordView *confirmPassword;


@property(nonatomic,strong)UIView *back;

@property(nonatomic,strong)UILabel *completeLabel;

@end

@implementation SetPasswordVC


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
    label.text=@"账户资料";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 30*WIDTH_SCALE-40, 31, 40, 22)];
    [self.view addSubview:rightButton];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upper];
    
    _accountLabel  = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, 66, SCREEN_WIDTH, 40)];
    NSMutableString *mutableString = [NSMutableString stringWithString:@"账号     "];
    NSString *accountStr = [mutableString stringByAppendingString:_account];
    _accountLabel.text=accountStr;
    _accountLabel.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:_accountLabel];
    
    
    _oldPassword = [[PasswordView alloc]initWithFrame:CGRectMake(0, _accountLabel.frame.origin.y+_accountLabel.frame.size.height, SCREEN_WIDTH, 40)];
    _oldPassword.password.text=@"原始密码";
    _oldPassword.textField.placeholder=@"请输入原始密码";
    _oldPassword.textField.secureTextEntry = YES;
    [self.view addSubview:_oldPassword];
    
    _newingPassword = [[PasswordView alloc]initWithFrame:CGRectMake(0, _oldPassword.frame.origin.y+_oldPassword.frame.size.height+1, SCREEN_WIDTH, 40)];
    _newingPassword.password.text=@"新密码";
    _newingPassword.textField.placeholder=@"请输入新密码";
    _newingPassword.textField.secureTextEntry = YES;
    [self.view addSubview:_newingPassword];
    
    _confirmPassword = [[PasswordView alloc]initWithFrame:CGRectMake(0, _newingPassword.frame.origin.y+_newingPassword.frame.size.height+1, SCREEN_WIDTH, 40)];
    _confirmPassword.password.text=@"确认密码";
    _confirmPassword.textField.placeholder=@"确认登陆新密码";
    _confirmPassword.textField.secureTextEntry = YES;
    [self.view addSubview:_confirmPassword];
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)complete{
    //     _completeLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 577*HEIGHT_SCALE, 200, SCREEN_HEIGHT-577*HEIGHT_SCALE-677*HEIGHT_SCALE)];
    //
    //    if ([_newingPassword.textField.text isEqualToString:_confirmPassword.textField.text]) {
    //
    //        _completeLabel.text=@"密码已修改完成";
    //
    //    }else{
    //         _completeLabel.text=@"新旧密码不相等";
    //
    //    }
    //
    //    _back =[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //
    //    _back.backgroundColor=RGBColor(191, 191, 191);
    //    _back.alpha=0.8;
    //    [self.view addSubview:_back];
    //
    //
    //    _back.userInteractionEnabled = YES;
    //    // hy:添加单击事件
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //    [_back addGestureRecognizer:tap];
    //
    //
    //    _completeLabel.backgroundColor=[UIColor whiteColor];
    //    _completeLabel.textAlignment=NSTextAlignmentCenter;
    //    _completeLabel.layer.cornerRadius=5;
    //    _completeLabel.clipsToBounds=YES;
    //    [self.view addSubview:_completeLabel];
    
    
    if ([StringUtil isNullOrBlank:_oldPassword.textField.text]
        || [StringUtil isNullOrBlank:_newingPassword.textField.text]
        || [StringUtil isNullOrBlank:_confirmPassword.textField.text]) {
        
        [self createAlertView];
        self.alertView.title=@"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    [self addLoadIndicator];
    [self netRequest];
}


-(void)tap{
    [_back removeFromSuperview];
    [_completeLabel removeFromSuperview];
    
    _back=nil;
    _completeLabel=nil;
}




-(void)netRequest{
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    request.context = self;
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_RESET_PASSWORD];
    
    [urlstring appendString:self.token];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    
    [dic setObject:_oldPassword.textField.text forKey:@"pwd"];
    [dic setObject:_newingPassword.textField.text forKey:@"newpwd"];
    [dic setObject:_confirmPassword.textField.text forKey:@"renewpwd"];
    
    NSLog(@"json data is : %@" ,dic);
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
            [self logout];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
    };
    
    [request netRequestWithUrl:urlstring Data:dic];
}




@end

