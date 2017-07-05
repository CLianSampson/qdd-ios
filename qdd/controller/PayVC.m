//
//  PayVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "PayVC.h"
#import "Macro.h"
#import "PayView.h"

#import "WXApi.h"
#import "payRequsestHandler.h"

@interface PayVC()

@property(nonatomic,assign) int payFlag; //1微信 2支付宝

@end

@implementation PayVC


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
    label.text=@"支付";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    [self creatView];
}


-(void)creatView{
    UILabel *upperLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upperLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upperLine];
    
    UILabel *background = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+2, SCREEN_WIDTH, 24*HEIGHT_SCALE)];
    background.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:background];
    
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0, background.frame.origin.y+background.frame.size.height+1, SCREEN_WIDTH, 1)];
    underLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underLine];
    
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, background.frame.origin.y+background.frame.size.height, SCREEN_WIDTH, 96*HEIGHT_SCALE)];
    NSString *pricetsr = [NSString stringWithFormat:@"%d",_price];
    
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:@"   需要支付: "];
    [mutableStr appendString:pricetsr];
    [mutableStr appendString:@"元"];
    
    price.text=mutableStr;
    price.font=[UIFont systemFontOfSize:14];
    price.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:price];
    
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(0, price.frame.origin.y+price.frame.size.height, SCREEN_WIDTH, 89*HEIGHT_SCALE)];
    type.text=@"   选择支付方式";
    type.font=[UIFont systemFontOfSize:14];
    type.textColor=RGBColor(0, 0, 0);
    type.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:type];
    
    
    PayView *ailPay = [[PayView alloc]initWithFrame:CGRectMake(0, type.frame.origin.y+type.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    [ailPay.icon setImage:[UIImage imageNamed:@"支付宝图标"]];
    ailPay.name.font=[UIFont systemFontOfSize:13];
    //默认支付宝
    [ailPay.choose setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    _payFlag = 2;
    [self.view addSubview:ailPay];
   
    
    
    PayView *weChat = [[PayView alloc]initWithFrame:CGRectMake(0, ailPay.frame.origin.y+ailPay.frame.size.height, SCREEN_WIDTH, 97*HEIGHT_SCALE)];
    weChat.name.text=@"微信";
     [weChat.icon setImage:[UIImage imageNamed:@"微信图标"]];
    weChat.name.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:weChat];
    
    
    __weak typeof(ailPay) weakAilPay = ailPay;
    ailPay.payBlock = ^(){
        [weakAilPay.choose setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [weChat.choose  setBackgroundImage:[UIImage imageNamed:@"未选中按钮"] forState:UIControlStateNormal];
        _payFlag = 2;
    };

    __weak typeof(weChat) weakWeChat = weChat;
    weChat.payBlock = ^(){
        [weakWeChat.choose setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [ailPay.choose  setBackgroundImage:[UIImage imageNamed:@"未选中按钮"] forState:UIControlStateNormal];
        _payFlag = 1;
    };
    

    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, weChat.frame.origin.y+weChat.frame.size.height+178*HEIGHT_SCALE, 650*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setBackgroundColor:RGBColor(0, 54, 99)];
    confirm.titleLabel.font=[UIFont systemFontOfSize:17];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirm.layer.cornerRadius=5;
    [self.view addSubview:confirm];
    
    
    
}


-(void)confirm{
    if (_payFlag == 1) {
        //微信
        [self wechatPay];
        
    }else{
        //支付宝
        
    }
    
//    [super createAlertView];
//    self.alertView.title=@"您已成功支付123.56元";
//    [self.alertView show];
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)wechatPay{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    [dic setObject:_orderId forKey:@"orderid"];
    [dic setObject:@"套餐" forKey:@"name"];
    [dic setObject:[NSString stringWithFormat:@"%d",_price] forKey:@"price"];

    
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_WXPAY];
    [urlstring appendString:self.token];

    AFNetRequest *request = [[AFNetRequest alloc]init];

    __weak typeof(self) weakSelf = self;
    
    request.netSucessBlock=^(id result){
        NSLog(@"获取微信 prepayid成功");
        NSLog(@"result is :%@",result);
        
        
        NSString *state = [result objectForKey:@"return_code"];
        NSString *info = [result objectForKey:@"return_msg"];
        
//        state = @"success";
        
        if ([state isEqualToString:@"success"]) {
            
            //支付请求发送成功后移除网络等待指示图标
            [weakSelf.indicator removeFromSuperview];
            if ([WXApi isWXAppInstalled]) {
                //创建支付签名对象
                payRequsestHandler *req = [payRequsestHandler alloc];
                //初始化支付签名对象
                [req init:APP_ID mch_id:MCH_ID];
                //设置密钥
                [req setKey:PARTNER_ID];
                
                //获取到实际调起微信支付的参数后，在app端调起支付
                NSString *PriceStr = [[NSString alloc]initWithFormat:@"%d",weakSelf.price];
                NSMutableDictionary *dict = [req sendPay_demo:PriceStr atprepayid:result[@"item"][@"prepayid"]];
                if(dict == nil){
                    //错误提示
                    NSString *debug = [req getDebugifo];
                    NSLog(@"%@\n\n",debug);
                }else{
                    NSLog(@"%@\n\n",[req getDebugifo]);
                    //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
                    
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.openID              = [dict objectForKey:@"appid"];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [dict objectForKey:@"package"];
                    req.sign                = [dict objectForKey:@"sign"];
                    
                    [WXApi sendReq:req];
                    
                }
            }else{
                UIAlertView *alertNo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未安装微信!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertNo show];
            }

            
        }else if ([state isEqualToString:@"FAIL"]){
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


-(void)ailPay{
    
}

@end
