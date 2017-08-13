//
//  BaseVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"
#import "Macro.h"
#import "AFNetRequest.h"
#import "AFNetworking.h"
#import "MainVC.h"
#import "MainLeftVC.h"
#import "MainRigthVC.h"
#import "SaveToMemory.h"
#import "Constants.h"
#import "LoginVC.h"

@implementation BaseVC


-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNetRequestFailedBlock];

}

-(void)createBackgroungView{
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
}


-(void)createAlertView{
    
    _alertView =[[UIAlertView alloc]initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    _alertView.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-30, 100, 60);
    
}

-(void)createNavition{
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_leftButton];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    _mytitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
//    _mytitle.text=@"消息";
    _mytitle.textAlignment=NSTextAlignmentCenter;
    _mytitle.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:_mytitle];

}

-(void)showLeft{
    
}


-(void)addLoadIndicator{
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //设置背景色
    _indicator.backgroundColor = [UIColor grayColor];
    //设置背景透明
    _indicator.alpha = 0.8;
    //设置背景为圆角矩形
    _indicator.layer.cornerRadius = 6;
    _indicator.layer.masksToBounds = YES;
    //设置显示位置
    [_indicator setCenter:CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT/ 2.0)];
    //开始显示Loading动画
    [_indicator startAnimating];
    
    [self.view addSubview:_indicator];
}

//AlertView已经消失时执行的事件,alertView代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}


-(void)netRequestWithUrl:(NSString *)url Data:(id )data{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //AFSSLPinningModeNone 这个模式表示不做 SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
    //AFSSLPinningModeCertificate 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
    //AFSSLPinningModePublicKey 这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
    
    /***************************https**********************************/
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];//设置证书类型
    securityPolicy.allowInvalidCertificates = YES; //允许自签证书
    manager.securityPolicy=securityPolicy;
    
    //是否验证域名（一般不验证）(若是ip 则不用)
    securityPolicy.validatesDomainName=NO;
    /***************************https**********************************/
    
    //设置返回值的解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    __weak typeof(self) weakSelf=self;
    
    
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"raw response is : %@",responseObject);
        
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"response jaon is : %@",result);
        
        
        weakSelf.netSucessBlock(result);
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is : %@",error);
    }];
    
}


-(void)netRequestGetWithUrl:(NSString *)url Data:(id )data{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //AFSSLPinningModeNone 这个模式表示不做 SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
    //AFSSLPinningModeCertificate 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
    //AFSSLPinningModePublicKey 这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
    
    /***************************https**********************************/
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];//设置证书类型
    securityPolicy.allowInvalidCertificates = YES; //允许自签证书
    manager.securityPolicy=securityPolicy;
    
    //是否验证域名（一般不验证）(若是ip 则不用)
    securityPolicy.validatesDomainName=NO;
    /***************************https**********************************/
    
    [manager.requestSerializer setValue:@"text/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //设置返回值的解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
      __weak typeof(self) weakSelf=self;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject is : %@",result);
        
        weakSelf.netSucessBlock(result);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        weakSelf.netFailedBlock(nil);
    }];
}


- (void)downLoad:(NSString *)urlString{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
   
    AFHTTPResponseSerializer *serializer=[AFHTTPResponseSerializer serializer];
//    serializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"]; // 设置相应的 http header Content-Type
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",@"image/jpg",@"image/gif",@"image/jpeg", nil];
    session.responseSerializer=serializer;
    
    [session GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSLog(@"down load sucess");
        
        self.pictureBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
        NSLog(@"%@",error);
    }];
}



- (void)upLoad:(NSString *)urlString image:(UIImage *)image{
    
        //1。创建管理者对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //上传文件参数
            NSData *data = UIImagePNGRepresentation(image);
            //这个就是参数
            [formData appendPartWithFileData:data name:@"sign" fileName:@"123.png" mimeType:@"image/png"];
    
        } progress:^(NSProgress * _Nonnull uploadProgress) {
    
            //打印下上传进度
            NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            //请求成功
            NSLog(@"请求成功：%@",responseObject);
    
            self.netSucessBlock(responseObject);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
            //请求失败
            NSLog(@"请求失败：%@",error);
            self.netFailedBlock(nil);
        }];
}

//- (void)upLoad:(NSString *)urlString image:(UIImage *)image{
//    
//    NSData *data;
//    if (UIImagePNGRepresentation(image) == nil) {
//        
//        data = UIImageJPEGRepresentation(image, 1);
//        
//    } else {
//        
//        data = UIImagePNGRepresentation(image);
//    }
//
//    NSMutableURLRequest *urlRequest=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:250];
//    [urlRequest setHTTPMethod:@"POST"];
//    
//    //表单分界符
//    static NSString * const BOUNDRY = @"0xKhTmLbOuNdArY";
//
//    
//    //设置请求头
//    [urlRequest setValue:
//     [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDRY]
//      forHTTPHeaderField:@"Content-Type"];
//   
//    
//    NSMutableData *postData =
//    [NSMutableData dataWithCapacity:[data length] + 512];
//    
//    //http协议规定必须以  --BOUNDRY   开头， 每行以 \r\n 结束， 在此由于服务端进行处理，不加也可以。
//    [postData appendData:
//     [[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //文件名
//    //以下字符串中‘\’，表示转义字符，作用是说明下一个“不表示字符串的结束,文件名自定义
//    [postData appendData:
//     [[NSString stringWithFormat:
//       @"Content-Disposition: form-data; name=\"File\"; filename=\"icon.png\"\r\n\r\n\r\n\r\n"]
//      dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    
//    //http协议规定，必须以 --BOUNDRY-- 结束，在此由于服务端进行处理，不加也可以。
//    
//    [postData appendData:data];
//    [postData appendData:
//     [[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
//    
//    [urlRequest setHTTPBody:postData];
//    
//    
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (connectionError) {
//            self.netFailedBlock(nil);
//            return ;
//        }
//        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"上传图片的返回是 :%@",result);
//        
//         self.netSucessBlock(result);
//    }];
//
//}


-(void)setNetRequestFailedBlock{
    
    __weak typeof(self) weakSelf=self;

    
    self.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };

}


-(void)gotoMainController{
    MainVC *VC = [[MainVC alloc]init];
    VC.token=self.token;
    
    
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    
    
    MainLeftVC *leftVC = [[MainLeftVC alloc] init];
    MainRigthVC *rightVC = [[MainRigthVC alloc] init];
    leftVC.token=self.token;
    rightVC.token=nil;
    
    leftVC.authState = self.authState;
    
    leftVC.verifyState = self.verifyState;
    
    leftVC.accountFlag = self.accountFlag;
    
    RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
    
    MenuVC.contentViewScaleValue=(float)305/445;
    
    [self presentViewController:MenuVC animated:YES completion:nil];
    
    //清空navigationController
    [self clearController];

}



-(void)logout{
    //清空存储的内容
    SaveToMemory *saveToMemory = [[SaveToMemory alloc]init];
    NSString *filePath = [saveToMemory filePath:STORE_PATH];
    NSDictionary *dic = [[NSDictionary alloc]init];
    [saveToMemory SaveDictionary:dic ToMemory:filePath];
    
    [self clearController];

    LoginVC *VC = [[LoginVC alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}

-(void)clearController{
    NSMutableArray * array =[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    [array removeAllObjects];
}


-(void)saveToMemory{
    //存储到磁盘
    NSDictionary *saveDic = [[NSMutableDictionary alloc]init];
    [saveDic setValue:self.token forKey:TOKEN_KEY];
    [saveDic setValue:[NSNumber numberWithInt:self.authState] forKey:AUTH_STATE_KEY];
    [saveDic setValue:[NSNumber numberWithInt:self.verifyState] forKey:VERIFY_STATE_KEY];
    [saveDic setValue:self.phoneToSave forKey:PHONE_KEY];
    
    if ([StringUtil isPhoneNum:self.phoneToSave]) {
        self.accountFlag = USER_ACCOUNT;
    }else{
        self.accountFlag = ENTERPRISE_ACCOUNT;
    }
    [saveDic setValue:[NSNumber numberWithInt:self.accountFlag] forKey:ACCOUNT_FLAG_KEY];
    
    
    SaveToMemory *saveToMemory = [[SaveToMemory alloc]init];
    NSString *filePath = [saveToMemory filePath:STORE_PATH];
    [saveToMemory SaveDictionary:saveDic ToMemory:filePath];
}



@end
