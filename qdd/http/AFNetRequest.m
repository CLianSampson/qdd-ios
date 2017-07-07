//
//  AFNetRequest.m
//  
//
//  Created by Apple on 16/12/17.
//
//

#import "AFNetRequest.h"
#import "Macro.h"


@implementation AFNetRequest


-(instancetype)init{
    if (self == [super init]) {
        self.netFailedBlock = ^(id result){
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"网络有点问题哦，无法加载" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alertView.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-30, 100, 60);
            [alertView show];

        };
    }
    
    return self;
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
    
    
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject is : %@",responseObject);
        
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject is : %@",result);
        
        
        self.netSucessBlock(result);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is : %@",error);
    }];
    
}



//针对支付宝单独一个接口
-(void)netAlipay:(NSString *)url Data:(id )data{
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
    
    
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject is : %@",responseObject);
        
        self.netSucessBlock(responseObject);
        
        
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
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject is : %@",result);
        
        self.netSucessBlock(result);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        self.netFailedBlock(nil);
    }];
    
    
}















- (void)downLoad{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
    
}

/**
 *  AFN 3.0 上传
 *      有两种方式
 *          upLoad1 和 upLoad2
 */

//第一种方法是通过工程中的文件进行上传
- (void)upLoad1{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        UIImage *iamge = [UIImage imageNamed:@"123.png"];
        NSData *data = UIImagePNGRepresentation(iamge);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}


//文／WK_IOSDevelpoer（简书作者）
//原文链接：http://www.jianshu.com/p/11bb0d4dc649
//著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。


- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}


-(void)downLoadPicture:(NSString *)urlString{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *serializer=[AFHTTPResponseSerializer serializer];
    //    serializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"]; // 设置相应的 http header Content-Type
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",@"image/jpg",@"image/gif",@"image/jpeg", nil];
    session.responseSerializer=serializer;
    
    [session GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"down load sucess");
//        NSLog(@"responseObject is : %@",responseObject);
        
        self.pictureBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
        NSLog(@"%@",error);
        _pictureFailedBlock();
    }];

}


@end
