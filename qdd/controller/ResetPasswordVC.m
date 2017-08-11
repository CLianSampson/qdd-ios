//
//  ResetPasswordVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "PasswordView.h"
#import "Macro.h"
#import "SetPasswordSucessVC.h"
#import "SetPasswordFailedVC.h"

@interface ResetPasswordVC()

@property(nonatomic,strong)PasswordView *newingPassword;
@property(nonatomic,strong)PasswordView *confirmPassword;


@end

@implementation ResetPasswordVC





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
    label.text=@"设置新密码";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 65+16*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    underLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underLine];
    
        
    
    
    _newingPassword = [[PasswordView alloc]initWithFrame:CGRectMake(0, underLine.frame.origin.y+underLine.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _newingPassword.password.text=@"设置新密码";
    _newingPassword.textField.placeholder=@"请输入新密码";
    _newingPassword.password.font=[UIFont systemFontOfSize:14];
    _newingPassword.password.textColor=TextRGBColor;
    _newingPassword.textField.font=[UIFont systemFontOfSize:14];
    _newingPassword.textField.textColor=PlaceHoderRGBColor;
    [self.view addSubview:_newingPassword];
    
    _confirmPassword = [[PasswordView alloc]initWithFrame:CGRectMake(0, _newingPassword.frame.origin.y+_newingPassword.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _confirmPassword.password.text=@"确认新密码";
    _confirmPassword.textField.placeholder=@"请再次确认新密码";
    _confirmPassword.password.font=[UIFont systemFontOfSize:14];
    _confirmPassword.password.textColor=TextRGBColor;
    _confirmPassword.textField.font=[UIFont systemFontOfSize:14];
    _confirmPassword.textField.textColor=PlaceHoderRGBColor;
    [self.view addSubview:_confirmPassword];
    
    
    
    UILabel *remind =[[UILabel alloc]initWithFrame:CGRectMake(60*WIDTH_SCALE, _confirmPassword.frame.origin.y+_confirmPassword.frame.size.height+22*HEIGHT_SCALE, SCREEN_WIDTH, 10)];
    remind.textColor=RedRGBColor;
    remind.font=[UIFont systemFontOfSize:10];
    remind.text=@"提示: 密码为8－16位的字母，数字组合";
    [self.view addSubview:remind];
    
    
    UIButton *nextStep = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, remind.frame.origin.y+138*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStep.titleLabel.font=[UIFont systemFontOfSize:18];
    //    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];

    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextStepClick{
    NSString *newPasword = _newingPassword.textField.text;
    NSString *confirmPassword = _confirmPassword.textField.text;
    
    if ([newPasword isEqualToString:@""] || [confirmPassword isEqualToString:@""]) {
        UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"密码不能为空" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        
        
        
        alertView.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-30, 100, 60);
        [alertView show];
        
        return;
    }
    
    [self netRequest];
    
}


-(void)netRequest{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    
    
    [dic setObject:_newingPassword.textField.text forKey:@"password"];
    [dic setObject:_confirmPassword.textField.text forKey:@"repassword"];
    [dic setObject:_mobile forKey:@"mobile"];
    [dic setObject:_mobile_code forKey:@"mobile_code"];
    
    NSLog(@"json data is : %@" ,dic);
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    request.context = self;
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            
            
            SetPasswordSucessVC *VC=[[SetPasswordSucessVC alloc]init];
            [weakSelf.navigationController pushViewController:VC animated:YES];
            
        }else if ([state isEqualToString:@"fail"]){
           
            SetPasswordFailedVC *VC=[[SetPasswordFailedVC alloc]init];
            VC.reason = info;
            [weakSelf.navigationController pushViewController:VC animated:YES];

        }
        
    };
    
    request.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestWithUrl:URL_FORGET_PASSWORD Data:dic];
}



@end
