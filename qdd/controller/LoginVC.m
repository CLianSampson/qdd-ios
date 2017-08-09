//
//  LoginVC.m
//  qdd
//
//  Created by Apple on 17/3/8.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "LoginVC.h"
#import "Macro.h"
#import "MainVC.h"
#import "RESideMenu.h"
#import "RegisteVC.h"
#import "ForgetAndSetPasswordVC.h"
#import "AFNetRequest.h"
#import "MainRigthVC.h"
#import "MainLeftVC.h"
#import "SaveToMemory.h"
#import "Constants.h"



@interface LoginVC()

@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *passWord;

@property(nonatomic,strong)NSString *tokenString;

@property(nonatomic,assign)int observeState; //观察者状态，监控授权和认证成功

@property(nonatomic,strong)NSMutableDictionary *saveDic; //存储token和其他状态值

@end

@implementation LoginVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _observeState = 0;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-65/2, 163*HEIGHT_SCALE, 65, 102)];
    logo.image=[UIImage imageNamed:@"LOGO"];
    [self.view addSubview:logo];
    
    
    UILabel *account = [[UILabel alloc]initWithFrame:CGRectMake(62*WIDTH_SCALE, logo.frame.origin.y+logo.frame.size.height+100*HEIGHT_SCALE, 60, 18)];
    account.text=@"帐号";
    account.font=[UIFont systemFontOfSize:18];
    account.textColor=RGBColor(51, 51, 51);
    [self.view addSubview:account];
    
    
    _userName = [[UITextField alloc]initWithFrame:CGRectMake(account.frame.origin.x+account.frame.size.width+60*WIDTH_SCALE, logo.frame.origin.y+logo.frame.size.height+100*HEIGHT_SCALE, 200, 18)];
    _userName.placeholder=@"请输入帐号";
    [_userName setFont:[UIFont systemFontOfSize:18]];
    [_userName setTextColor:RGBColor(172, 172, 172)];
    [self.view addSubview:_userName];
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(31*WIDTH_SCALE, _userName.frame.origin.y+_userName.frame.size.height+20*HEIGHT_SCALE, SCREEN_WIDTH-2*31*WIDTH_SCALE, 1)];
    upper.backgroundColor = RGBColor(0, 51, 102);
    
    [self.view addSubview:upper];
    
    
    
    UILabel *pawword = [[UILabel alloc]initWithFrame:CGRectMake(62*WIDTH_SCALE, upper.frame.origin.y+upper.frame.size.height+94*HEIGHT_SCALE, 60, 18)];
    pawword.text=@"密码";
    pawword.font=[UIFont systemFontOfSize:18];
    pawword.textColor=RGBColor(51, 51, 51);
    [self.view addSubview:pawword];

    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(pawword.frame.origin.x+pawword.frame.size.width+60*WIDTH_SCALE, upper.frame.origin.y+upper.frame.size.height+94*HEIGHT_SCALE, 200, 18)];
    _passWord.placeholder=@"请输入密码";
    [_passWord setFont:[UIFont systemFontOfSize:18]];
    [_passWord setTextColor:RGBColor(172, 172, 172)];
    _passWord.secureTextEntry = YES;
    [self.view addSubview:_passWord];

    
    UILabel *under = [[UILabel alloc]initWithFrame:CGRectMake(31*WIDTH_SCALE, _passWord.frame.origin.y+_passWord.frame.size.height+20*HEIGHT_SCALE, SCREEN_WIDTH-2*31*WIDTH_SCALE, 1)];
    
    under.backgroundColor = RGBColor(0, 51, 102);
    [self.view addSubview:under];
    
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, under.frame.origin.y+102*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [login setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [login setTitle:@"登陆" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:18];
//    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
    UIButton *sign = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, login.frame.origin.y+login.frame.size.height+34*HEIGHT_SCALE, 100, 14)];
    [sign setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    [sign setTitle:@"注册" forState:UIControlStateNormal];
    sign.titleLabel.font=[UIFont systemFontOfSize:14];
    sign.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [sign addTarget:self action:@selector(sign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sign];
    
    
    UIButton *forgetPassword = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-2*36*WIDTH_SCALE-150, login.frame.origin.y+login.frame.size.height+34*HEIGHT_SCALE, 150, 14)];
    [forgetPassword setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    [forgetPassword setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPassword.titleLabel.font=[UIFont systemFontOfSize:14];
    forgetPassword.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [forgetPassword addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];
    
}


-(void)login{
    [self netRequest];
    
}

-(void)sign{
    RegisteVC *VC = [[RegisteVC alloc]init];
     UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];

}




-(void)forgetPassword{
    ForgetAndSetPasswordVC *VC = [[ForgetAndSetPasswordVC alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_passWord resignFirstResponder];
    [_userName resignFirstResponder];
}


-(void)netRequest{
    if ([StringUtil isNullOrBlank:_userName.text] || [StringUtil isNullOrBlank:_passWord.text] ) {
        
        [self createAlertView];
        self.alertView.title = @"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    
//    
//    [dic setObject:@"18771098004" forKey:@"username"];
//    [dic setObject:@"1234567" forKey:@"password"];
//    
//    _userName.text = @"18771098004";
    
    [dic setObject:_userName.text forKey:@"username"];
    [dic setObject:_passWord.text forKey:@"password"];

    
    NSLog(@"json data is : %@" ,dic);
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            
            [weakSelf doSucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
    };
    
    NSLog(@"登录");
    [request netRequestWithUrl:URL_LOGIN Data:dic];
}

-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    _tokenString =[data objectForKey:@"token"];
    
    [self auth];
    [self getUserInfo];
   
}



//判断用户是否授权
-(void)auth{
    
    if ([StringUtil isNullOrBlank:_tokenString]) {
        [self createAlertView];
        self.alertView.title=@"系统有点问题";
        [self.alertView show];
        
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_IS_AUTH];
    [urlstring appendString:_tokenString];
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf doAuthSucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    [request netRequestGetWithUrl:urlstring Data:nil];
}


-(void)doAuthSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        [self createAlertView];
        self.alertView.title=@"系统有点问题";
        [self.alertView show];

        return ;
    }
    
    NSString *authStateStr = [data objectForKey:@"auth"];
    
    if ([StringUtil isNullOrBlank:authStateStr]) {
        [self createAlertView];
        self.alertView.title=@"系统有点问题";
        [self.alertView show];
        return;
    }
    
    //设置授权状态
    if ([authStateStr intValue]==0) {
        self.authState = NOT_AUTH;
    }else if ([authStateStr intValue]==1){
        self.authState = HAVE_AUTH;
    }else{
        [self createAlertView];
        self.alertView.title=@"系统有点问题";
        [self.alertView show];
    }
    
    [self updateObserverState];
}


//获取用户资料 ，判断用户是否认证
-(void)getUserInfo{
    if ([StringUtil isNullOrBlank:_tokenString]) {
        [self createAlertView];
        self.alertView.title=@"系统有点问题";
        [self.alertView show];
        
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];

    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_GET_ACCOUNT_INFO];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:_tokenString];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf doVerifySucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    [request netRequestGetWithUrl:appendUrlString Data:nil];
}


-(void)doVerifySucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSString * status = [data objectForKey:@"cherk"];
    switch (status.intValue) {
        case 0:
            self.verifyState = NOT_VERIFY;
            break;
            
        case 1:
            self.verifyState = UNDER_VERIFYING;
            break;
            
        case 2:
            self.verifyState = HAVE_VERIFY;
            break;
        
        case 3:
            self.verifyState = NOT_PASS_VERIFY;
            break;

        default:
            break;
    }
    
    [self updateObserverState];
    
}

//相当于观察者
-(void)updateObserverState{
    _observeState++;
    if (_observeState==2) {
      
        MainVC *VC = [[MainVC alloc]init];
        VC.token=_tokenString;
        VC.authState = self.authState;
        
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
        
        
        MainLeftVC *leftVC = [[MainLeftVC alloc] init];
        MainRigthVC *rightVC = [[MainRigthVC alloc] init];
        leftVC.token=_tokenString;
        rightVC.token=nil;
        
        leftVC.authState = self.authState;
        
        leftVC.verifyState = self.verifyState;
        
        leftVC.phone = _userName.text;
        
        if ([StringUtil isPhoneNum:_userName.text]) {
            leftVC.accountFlag = USER_ACCOUNT;
        }else{
            leftVC.accountFlag = ENTERPRISE_ACCOUNT;
        }
        
        [self saveToMemory];
        
        
        RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
        
        MenuVC.contentViewScaleValue=(float)305/445;
        
        [self presentViewController:MenuVC animated:YES completion:nil];
    }
}

-(void)saveToMemory{
    //存储到磁盘
    _saveDic = [[NSMutableDictionary alloc]init];
    [_saveDic setValue:_tokenString forKey:TOKEN_KEY];
    [_saveDic setValue:[NSNumber numberWithInt:self.authState] forKey:AUTH_STATE_KEY];
    [_saveDic setValue:[NSNumber numberWithInt:self.verifyState] forKey:VERIFY_STATE_KEY];
    [_saveDic setValue:_userName.text forKey:PHONE_KEY];
    
    if ([StringUtil isPhoneNum:_userName.text]) {
        self.accountFlag = USER_ACCOUNT;
    }else{
        self.accountFlag = ENTERPRISE_ACCOUNT;
    }
    [_saveDic setValue:[NSNumber numberWithInt:self.accountFlag] forKey:ACCOUNT_FLAG_KEY];
    
    
    SaveToMemory *saveToMemory = [[SaveToMemory alloc]init];
    NSString *filePath = [saveToMemory filePath:STORE_PATH];
    [saveToMemory SaveDictionary:_saveDic ToMemory:filePath];
}

@end




