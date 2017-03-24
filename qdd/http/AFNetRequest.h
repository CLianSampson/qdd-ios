//
//  AFNetRequest.h
//  
//
//  Created by Apple on 16/12/17.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static  NSString *URL_SMS = @"https://www.qiandd.com/mobile/user/sms?";

static  NSString *URL_REGISTER = @"https://www.qiandd.com/mobile/user/doregister";

static  NSString *URL_PICTURE_CODE = @"https://www.qiandd.com/api/checkcode/index?length=4&font_size=14&width=100&height=26&charset=1234567890&use_noise=1&use_curve=0";


static NSString *URL_LOGIN = @"https://www.qiandd.com/mobile/user/dologin";

@interface AFNetRequest : NSObject



@end
