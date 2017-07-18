//
//  AppDelegate.m
//  qdd
//
//  Created by Apple on 17/2/18.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "MainLeftVC.h"
#import "MainRigthVC.h"
#import "RESideMenu.h"
#import "Macro.h"
#import "LoginVC.h"



#import "DemoPreDefine.h"
//#import "ViewController.h"
#import "iflyMSC/IFlyFaceSDK.h"

//微信头文件
#import "WXApi.h"

//支付宝头文件
//#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


#import "SaveToMemory.h"
#import "Constants.h"


@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    SaveToMemory *saveToMemory = [[SaveToMemory alloc]init];
    NSString *filePath = [saveToMemory filePath:STORE_PATH];
    NSDictionary *dic = [saveToMemory GetDictionary:filePath];
    if (nil != dic && [dic.allKeys count]!=0) {
        [self gotoMainVC:dic];
    }else{
        LoginVC *VC = [[LoginVC alloc]init];
        self.window.rootViewController=VC;
    }

    [self.window makeKeyAndVisible];
    
    //配置文件
    [self makeConfiguration];

    //向微信注册
    [WXApi registerApp:@"wxc4b128dfb589574c"];
    
    return YES;
}


-(void)gotoMainVC:(NSDictionary *)dic{
    
    MainVC *VC = [[MainVC alloc]init];
    VC.token=[dic objectForKey:TOKEN_KEY];
    VC.authState = [( (NSNumber *)[dic objectForKey:AUTH_STATE_KEY] ) intValue];

    
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    
    MainLeftVC *leftVC = [[MainLeftVC alloc] init];
    MainRigthVC *rightVC = [[MainRigthVC alloc] init];
    leftVC.token=[dic objectForKey:TOKEN_KEY];

    rightVC.token=nil;
    
    leftVC.authState = [( (NSNumber *)[dic objectForKey:AUTH_STATE_KEY] ) intValue];
    
    leftVC.verifyState =[( (NSNumber *)[dic objectForKey:VERIFY_STATE_KEY] ) intValue];
    
    leftVC.phone = [dic objectForKey:PHONE_KEY];
    
    leftVC.accountFlag = [( (NSNumber *)[dic objectForKey:ACCOUNT_FLAG_KEY] ) intValue];

    
    RESideMenu *MenuVC=[[RESideMenu alloc]initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
    
    MenuVC.contentViewScaleValue=(float)305/445;
    
    self.window.rootViewController=MenuVC;
}


#pragma mark --- 配置文件
-(void)makeConfiguration
{
    //设置log等级，此处log为默认在app沙盒目录下的msc.log文件
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,",USER_APPID];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    BOOL result = false;
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//        if ([url.host isEqualToString:@"safepay"]) {
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//            }];
//            [[AlipaySDK defaultService]
//             processOrderWithPaymentResult:url
//             standbyCallback:^(NSDictionary *resultDic) {
//                 NSLog(@"result = %@",resultDic);//返回的支付结果 //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接 口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方法 里面处理跟 callback 一样的逻辑】
//             }];
//            [[AlipaySDK defaultService] processAuth_V2Result:url
//                                             standbyCallback:^(NSDictionary *resultDic) {
//                                                 NSLog(@"result = %@",resultDic);
//                                                 NSString *resultStr = resultDic[@"result"];
//                                                 NSLog(@"result = %@",resultStr);
//                                             }];
//        }
//        else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
//            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//            }];
//        }
//        
//        return  [WXApi handleOpenURL:url delegate:self];
//    }
//
//    return result;
    
    NSLog(@"url is : %@",url);
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
         NSLog(@"result = %@",resultDic);//返回的支付结果
     }];
    return true;
}




// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    NSLog(@"支付宝微信回调成功，url is ：%@",url);
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}



//微信支付回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                //建议：第一次开发 用把通知注释（个人建议）
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                //建议：第一次开发 用把通知注释（个人建议）
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
                
            }
        }
    }
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
