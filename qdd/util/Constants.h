//
//  Constants.h
//  qdd
//
//  Created by Apple on 17/6/27.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//token存储路径
static NSString *const STORE_PATH = @"tokenstorepath";

//存储建
static NSString *const TOKEN_KEY = @"token";

static NSString *const AUTH_STATE_KEY = @"authState";

static NSString *const VERIFY_STATE_KEY = @"verifyState";

static NSString *const PHONE_KEY = @"phone";

static NSString *const ACCOUNT_FLAG_KEY = @"accountFlag";


//个人认证成功之后的发送的通知
static  NSString *const CHANGE_VERIFY_STATE_AFTER_USER_VERIFY = @"change verify state after user verify";

//企业认证成功之后的发送的通知
static  NSString *const GOTO_MAIN_CONTROLLER_FROM_ENTERPRISE_VERIFY_CONTROLLER = @"go to main controller from enterpeise controller";

//绑定邮箱成功之后发送的通知
static  NSString *const GOTO_MAIN_CONTROLLER_FROM_BIND_MAIL_SUCESS_CONTROLLER = @"go to main controller from bind mail sucess controller";

//签完合同发送的通知
static  NSString *const GOTO_MAIN_CONTROLLER_FROM_SIGN_SUCESS_CONTROLLER = @"go to main controller from sign sucess sucess controller";


#endif /* Constants_h */
