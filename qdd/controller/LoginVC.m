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
#import "LeftVC.h"
#import "RightVC.h"
#import "RegisteVC.h"

@interface LoginVC()

@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *passWord;

@end

@implementation LoginVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
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
    MainVC *VC = [[MainVC alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];


    LeftVC *leftVC = [[LeftVC alloc] init];
    RightVC *rightVC = [[RightVC alloc] init];

     UINavigationController *leftNav =[[UINavigationController alloc]initWithRootViewController:leftVC];


     RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];

     MenuVC.contentViewScaleValue=0.69;
    
    
    [self presentViewController:MenuVC animated:YES completion:nil];

    
}

-(void)sign{
    RegisteVC *VC = [[RegisteVC alloc]init];
     UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];

}




-(void)forgetPassword{
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_passWord resignFirstResponder];
    [_userName resignFirstResponder];
}

@end
