//
//  AFNetRequest.h
//  
//
//  Created by Apple on 16/12/17.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static  NSString *URL_SMS = @"https://www.qiandd.com/mobile/user/sms?"; //短信验证码

static  NSString *URL_REGISTER = @"https://www.qiandd.com/mobile/user/doregister"; //注册

static  NSString *URL_PICTURE_CODE = @"https://www.qiandd.com/api/checkcode/index?length=4&font_size=14&width=100&height=26&charset=1234567890&use_noise=1&use_curve=0"; //图片验证码


static NSString *URL_LOGIN = @"https://www.qiandd.com/mobile/user/dologin"; //登陆

static NSString *URL_LIST_SIGN =@"https://www.qiandd.com/mobile/Contract/index/token/"; //合同列表


static NSString *URL_LIST_MESSAGE=@"https://www.qiandd.com/mobile/Message/index/token/";//消息列表

static NSString *URL_MESSAGE_DETAIL=@"https://www.qiandd.com/mobile/Message/show/token/";

static NSString *URL_COMMENT=@"https://www.qiandd.com/mobile/Question/add/token/";//意见反馈

static NSString *URL_LIST_ORDER=@"https://www.qiandd.com/mobile/order/allindex/token/";// 订单列表

static NSString *URL_LIST_SIGNATURE=@"https://www.qiandd.com/mobile/Sign/signindex/token/";//签名列表

static NSString *URL_UPLOAD_PICTURE=@"https://www.qiandd.com/mobile/Iden/picuploadt/token/";//上传图片

static NSString *URL_FORGET_PASSWORD=@"https://www.qiandd.com/mobile/user/do_mobile_forgot_password";//修改密码



@interface AFNetRequest : NSObject



@end
