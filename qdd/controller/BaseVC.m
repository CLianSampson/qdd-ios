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


@implementation BaseVC


-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
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
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject is : %@",result);
        
        
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
    
    

    
    //    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
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
        
    }];
    
    
}


- (void)downLoad:(NSString *)urlString{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
   
    AFHTTPResponseSerializer *serializer=[AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"]; // 设置相应的 http header Content-Type
    session.responseSerializer=serializer;
    
    [session GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        self.pictureBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
        NSLog(@"%@",error);
    }];
    
    
}




@end
