//
//  SignMobileVerifyVC.m
//  qdd
//
//  Created by Apple on 17/4/17.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignMobileVerifyVC.h"
#import "UILabel+Adjust.h"
#import "GetVerifyCodeView.h"
#import "SignSucessVC.h"

@interface SignMobileVerifyVC()<SendSmsCodeDelegete>

@property(nonatomic,strong)GetVerifyCodeView *code;
@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)NSString *mealTimes; //剩余套餐使用次数

@end

@implementation SignMobileVerifyVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"签署验证";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UILabel *backGround = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    backGround.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backGround];
    
    [self createView];
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createView{
    UILabel *upperText = [[UILabel alloc]initWithFrame:CGRectMake(30, 64+60*HEIGHT_SCALE, SCREEN_WIDTH-60*WIDTH_SCALE, 12)];
    upperText.text=@"为了确保合同身份签署主体性, 需要在您手机上进行验证";
    upperText.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:upperText];
    
    UILabel *underText = [[UILabel alloc]initWithFrame:CGRectMake(30, upperText.frame.origin.y+upperText.frame.size.height+32*HEIGHT_SCALE, SCREEN_WIDTH-60*WIDTH_SCALE, 12)];
    underText.text=@"验证码将发送至您手机:  ";
    underText.font=[UIFont systemFontOfSize:12];
    
    float underTextWidth = [UILabel getWidthWithTitle:underText.text font:underText.font];
    underText.frame=CGRectMake(30, upperText.frame.origin.y+upperText.frame.size.height+32*HEIGHT_SCALE, underTextWidth, 12);
    [self.view addSubview:underText];
    
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(underText.frame.origin.x+underText.frame.size.width, underText.frame.origin.y-1.5, 150, 15)];
    _phoneLabel.text = _phoneNum;
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    _phoneLabel.textColor = BlueRGBColor;
    [self.view addSubview:_phoneLabel];
    
    
    _code = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, underText.frame.origin.y+underText.frame.size.height+45*HEIGHT_SCALE, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _code.delegate=self;
    [self.view addSubview:_code];
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, _code.frame.origin.y+2*127*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    [confirm addTarget:self action:@selector(verifySmsCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, confirm.frame.origin.y+confirm.frame.size.height+30*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.titleLabel.font=[UIFont systemFontOfSize:18];
    [cancel addTarget:self action:@selector(signCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    cancel.layer.borderColor=BlueRGBColor.CGColor;
    cancel.layer.borderWidth=1;
    cancel.layer.cornerRadius=6;
    [self.view addSubview:cancel];
    
}

#pragma mark GetVerifyCodeView delegate
-(void)sendSmsCode{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SIGN_GET_SMS_CODE];
    [urlstring appendString:self.token];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_phoneNum forKey:@"mobile"];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
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
    
    [request netRequestWithUrl:urlstring Data:dic];
    
}


-(void)verifySmsCode{
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_VERIFY_MOBILE_CODE];
    [urlstring appendString:self.token];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_phoneNum forKey:@"mobile"];
    [dic setObject:_code.textField.text forKey:@"mobile_code"];
    [dic setObject:_signId forKey:@"id"];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            [weakSelf signSignature];
            
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
    
    [request netRequestWithUrl:urlstring Data:dic];
}


#pragma mark   //签合同
-(void)signSignature{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SIGN_SIGNATURE];
    [urlstring appendString:self.token];
    [urlstring appendString:@"/id/"];
    [urlstring appendString:_signId];
    
    NSString *string= [NSString stringWithFormat:@"/status/%d",_signStatus];
    
   [urlstring appendString:string];
    
    NSLog(@"url is : %@",urlstring);
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            _mealTimes = (NSString *)[result objectForKey:@"data"];
            
            SignSucessVC *VC = [[SignSucessVC alloc]init];
            VC.mealTimes = weakSelf.mealTimes;
            [weakSelf.navigationController pushViewController:VC animated:YES];
            
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



-(void)signCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_code.textField resignFirstResponder];
}

@end
