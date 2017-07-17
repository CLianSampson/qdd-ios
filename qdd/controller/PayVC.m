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
#import "Order.h"
#import "PayUtil.h"

//支付宝头文件
//#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

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
    NSString *pricetsr = [NSString stringWithFormat:@"%.2f",(float)_price/100];
    
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
        [self ailPay];
        
    }
    
//    [super createAlertView];
//    self.alertView.title=@"您已成功支付123.56元";
//    [self.alertView show];
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 微信支付
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
                NSString *PriceStr = [[NSString alloc]initWithFormat:@"%d",(int)weakSelf.price*100];
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

#pragma mark 支付宝支付
-(void)ailPay{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    [dic setObject:_orderId forKey:@"WIDout_trade_no"];
    [dic setObject:@"套餐" forKey:@"WIDsubject"];
    [dic setObject:@"套餐" forKey:@"WIDbody"];
    [dic setObject:[NSString stringWithFormat:@"%d",_price] forKey:@"WIDtotal_fee"];
    
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_AILPAY];
    [urlstring appendString:self.token];
    
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未安装支付宝!"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        
        __weak typeof(self) weakSelf = self;
        //支付宝
        AFNetRequest *request = [[AFNetRequest alloc]init];
        request.netSucessBlock=^(id result){
            NSLog(@"获取支付宝paysign成功");
            NSLog(@"result is :%@",result);
            
            NSString *orderString = [[NSString alloc] initWithData:result  encoding:NSUTF8StringEncoding];
           
            NSString *appScheme = @"addalipay";
            
//            orderString = @"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017041206666762&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF1%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%222017071215462882370%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E9%AD%85%E6%A0%BCss%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=JSON&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Ftaxipassenger.yaotaxi.com%2Fssm-crud%2Fcallbacks.do&sign=ZT5eygFAI4Bh%2F9MFAj5UXDy7aGMV2sxzoiBk7EBZTSQSIrTl6x194Ni5POOeqgL7idVY6u2deIFVNhYOOHyDpNWLPiM%2FaawFZe9IkfMuWee58a0GdywXD1vJ2iE3ZjN7JG3rVXGOzrWh7KpyLHV7m7AkOnEyzjCBZPJojCrV6RVtxbcfydAITx2q2iXMts0TrEkI%2FM%2BsO%2FfmJzLkYkvo0%2FotlonY%2BCUWjaikUvkevFF1WnKCB2iO4UlK8a8jqUakNRp49hv83YsnYuhqEpAFdw2ZJTg%2F3dB8wJ23ZDSzJ7vIby%2F2rBHhn5n26QTULyP6rEUCNm8%2Fxb03Dc7bW3Ee6g%3D%3D&sign_type=RSA×tamp=2017-07-12+15%3A46%3A28&version=1.0";
            
            NSLog(@"orderString is : %@",orderString);
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSLog(@"reslut = %@",resultDic);
                            if ([[resultDic objectForKey:@"resultStatus"]integerValue] == 9000) {
                                UIAlertView * alert1 = [[UIAlertView alloc]initWithTitle:@"您已成功支付" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert1 show];
                
                                
                            }else{
                                UIAlertView * alert2 = [[UIAlertView alloc]initWithTitle:@"充支付失败" message:@"请重新支付" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert2 show];
                            }
                        }];

            
        };
        
    
        
        request.netFailedBlock=^(id result){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=@"网络有点问题哦，无法加载";
            [weakSelf.alertView show];
        };
        NSLog(@"支付宝支付的url is : %@",urlstring);
        NSLog(@"支付宝支付发送的参数 is : %@",dic);
        [request netAlipay:urlstring Data:dic];

    }

}

//#pragma 支付宝
//- (void)payToPrice:(NSString *)price andId:(NSString *)payid withURL:(NSString *)url{
//    
//    NSLog(@"订单号是 ：%@",payid);
//    
//    NSString *partner = @"2088021957265821";
//    NSString *seller = @"pay@yaotaxi.com";
//    NSString *privateKey = @"MIIEpAIBAAKCAQEAt5aMEMXWDIMLLb3921o/W4aOXR/YyMH+Shj9pqLAWgwYme/JTBXNXdyjsmBHXn0mjpTJuHYCcxL3n9W988/hyJRbI18UApu/Wf5LVfmwdlrcoeP/mUMltGalcfiJp5VXvHyrIKEGzj5vm7RcP1wbrM7A2i3dzLUAPdi9+P90CrJgo1MUVuMainaQwAR5tH4DMucDOxWELYklICAwqFwWeetKRvBva/DlVW2X+eWCmrfSW8OegYYgjqxRJSH03ciypOrXjAK2qwcvMuF9z4GoxHgFjiwOKCORM0U7FN13Daqqc6uZ/JegCnsOKGP4azkWmHoTnCFOdUc4CF4yK2BTSQIDAQABAoIBAB1ZXujrh62WYXodjnC7u7c5CpdOmQx3Htzfo+U4zYFXv7MUR1z3e05PEIhape4wGbLfjGQF0Zxt4tJVjDlm+VRkizFbaMqF9ZBAe/Cxqwkwu2bSGTF6L5PoePiAYBk/YbhLQdxEgd8E0jjVG44xfmcg4mm+vV+VbAV3Gd+tjvKKjiI3ji3EnNGqJpEAS5EGp4DfiODlS/I7OV1boOjr4s9fYTwxRk0w4Na6k2rl9ondhMa9N+BDpFLc2hZQ9nmfa+YSroV6EBi/vmpgHI8DZZ88LgNtxohcwQSCvkmbkMZv2zOTKX2Z6AZYIbtQ2x7gmCStS5ZAde/b5c3oh46mF5ECgYEA6+w4LN6M0gsVs0hO+eR1nCVaSDGzbEt9gDY2HyeitOUEMHXGeCXFCVHbOZI3s1SYC5t19UIgSYTsRdDrNe5dUm+R/2xiHFIqtSwxmP8nk8Vq5kbM73UhoggEZOigKfS33MWpqyyzkYxoDQi/HHCWMDuehsRCy9HCOVIiEC7avhUCgYEAxzYsBehTSbAmfEm6B7vYNG+tepepLVLUs3AiEM4jNqTak1cTq2sJ3s8gD4sZgZOUe/Nx4eY/iWv/NWapIPO48UnI1lxCax6vyDBohbY7hf2ESHXgIog3PbHkoDaBakWsLBWAy4jTYINMpLnV6b3/NnoLzUN6OgL9MkX5iZWQQWUCgYB59mw0BfkWvNRDEqaBWTHTvxulJsxyt7PxjBT+libvDVXVF426nwv1fXOvl39kHd9cYMniOIUofKcIkLCH+OoVq8f2G7m8ml2pu2cIiR+UrQJOeVuIjy0L7skWwYvLJM/IOgc0jq9mFwfTdSoXMbzywl95nAxMAew+Zc9mPlKm4QKBgQCl76vP5+uoj8Ae+1KoKoI3e2bnnPjgtgRSy260zOBsHfmrjXbm7Kw2GhW8nMNMOeAPN4N/Bcma8IiOtMrgleNRqYJPfF4e2FrXx+rophkCzV+o8/cVDJ3nGA02nvBB03NM7URxRbG8zOHEvL9AinDRseuuuSxQsjix7bOkNR8KOQKBgQCGGMMiVcNQIR/6JtnP9SKrI2m4tOMiCcNXBRZmgQMAcstMJ8bARxWDJ0Mq8US7b5tb11r9efg998c1pi1X+VTFmhIUM5azT8zCwnY01TEOmbog9uS/nZ2/QWFNEomNYF54NEVjOQhfsVBX4LOlae9zU7em5ZaR5K/7ZNiWcX0AaQ==";
//    
//    
//    
//
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alertt = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                         message:@"缺少partner或者seller或者私钥。"
//                                                        delegate:self
//                                               cancelButtonTitle:@"确定"
//                                               otherButtonTitles:nil];
//        [alertt show];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    
////    order.tradeNO=_tradnedo;
//    order.tradeNO=payid; //服务端返回的交易号
//    order.productName = @"支付"; //商品标题
//    order.productDescription = @"支付"; //商品描述
//    
////    order.amount = _pricestr; //商品价格
//    order.amount = [NSString stringWithFormat:@"%d",_price];
//    
//    order.notifyURL = url; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //    获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        NSLog(@"支付宝开始支付了");
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//            if ([[resultDic objectForKey:@"resultStatus"]integerValue] == 9000) {
//                UIAlertView * alert1 = [[UIAlertView alloc]initWithTitle:@"您已成功充值" message:@"请支付" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                alert1.tag=2222;
//                [alert1 show];
//                
//                //              [self notifyServerAfterPaySucess];
//                
//            }else{
//                UIAlertView * alert2 = [[UIAlertView alloc]initWithTitle:@"充值失败" message:@"请重新充值" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert2 show];
//            }
//        }];
//        
//        NSLog(@"支付宝支付之后 ....");
//    }
//}


@end
