//
//  VerifyVC.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "VerifyVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "VerifyTypeView.h"
#import "GetVerifyCodeView.h"
#import "PasswordView.h"
#import "PhotoVC.h"
#import "FaceDetectVC.h"

@interface VerifyVC()


@property(nonatomic,strong)PasswordView *name;
@property(nonatomic,strong)PasswordView *idNum;
@property(nonatomic,strong)PasswordView *bankNum;
@property(nonatomic,strong)PasswordView *phone;

@property(nonatomic,strong)GetVerifyCodeView *code ;

@end

@implementation VerifyVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [super createNavition];
    self.mytitle.text=@"实名认证";
    
    [super createBackgroungView];
    
    
    [self creteView];
    
}



-(void)creteView{
    VerifyTypeView *verifyType =[[VerifyTypeView alloc]initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, 77*HEIGHT_SCALE)];
    [self.view addSubview:verifyType];
    
    _name = [[PasswordView alloc]initWithFrame:CGRectMake(0, verifyType.frame.origin.y+verifyType.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _name.password.text=@"姓名";
    _name.textField.placeholder=@"请输入姓名";
    _name.password.textColor=RGBColor(51, 51, 51);
    _name.textField.textColor=RGBColor(172, 172, 172);
    _name.password.font=[UIFont systemFontOfSize:14];
    _name.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_name];
    
    
    _idNum = [[PasswordView alloc]initWithFrame:CGRectMake(0, _name.frame.origin.y+_name.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _idNum.password.text=@"身份证号";
    _idNum.textField.placeholder=@"请输入身份证号";
    _idNum.password.textColor=RGBColor(51, 51, 51);
    _idNum.textField.textColor=RGBColor(172, 172, 172);
    _idNum.password.font=[UIFont systemFontOfSize:14];
    _idNum.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_idNum];

    _bankNum = [[PasswordView alloc]initWithFrame:CGRectMake(0, _idNum.frame.origin.y+_idNum.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _bankNum.password.text=@"银行卡号";
    _bankNum.textField.placeholder=@"请输入银行卡号";
    _bankNum.password.textColor=RGBColor(51, 51, 51);
    _bankNum.textField.textColor=RGBColor(172, 172, 172);
    _bankNum.password.font=[UIFont systemFontOfSize:14];
    _bankNum.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_bankNum];

    _phone = [[PasswordView alloc]initWithFrame:CGRectMake(0, _bankNum.frame.origin.y+_bankNum.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _phone.password.text=@"手机号码";
    _phone.textField.placeholder=@"请输入手机号码";
    _phone.password.textColor=RGBColor(51, 51, 51);
    _phone.textField.textColor=RGBColor(172, 172, 172);
    _phone.password.font=[UIFont systemFontOfSize:14];
    _phone.textField.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_phone];

    
    
    _code = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, _phone.frame.origin.y+_phone.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    [self.view addSubview:_code];
    
    
    
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, _code.frame.origin.y+_code.frame.size.height+102*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [login setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [login setTitle:@"确定" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:18];
    //    [login setBackgroundColor:RGBColor(0, 54, 99)];
    [login addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];

    
    
}



-(void)confirm{
    if ([_name.textField.text isEqualToString:@""]
        || [_idNum.textField.text isEqualToString:@""]
        || [_bankNum.textField.text isEqualToString:@""]
        || [_phone.textField.text isEqualToString:@""]
        || [_code.textField.text isEqualToString:@""]) {
        
        [super createAlertView];
        self.alertView.title=@"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    
//    PhotoVC *VC =[[PhotoVC alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
    
    FaceDetectVC *VC =[[FaceDetectVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_name.textField resignFirstResponder];
     [_idNum.textField resignFirstResponder];
     [_bankNum.textField resignFirstResponder];
     [_phone.textField resignFirstResponder];
     [_code.textField resignFirstResponder];
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];

}


@end
