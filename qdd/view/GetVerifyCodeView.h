//
//  GetVerifyCodeView.h
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendSmsCodeDelegete <NSObject>

-(void)sendSmsCode;

@end

@interface GetVerifyCodeView : UIView



@property(nonatomic,strong)UILabel *verifyCode;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)UILabel *smsCode;

@property(nonatomic,assign)id<SendSmsCodeDelegete> delegate;


@property(nonatomic,strong)NSString *phone;  //获取手机号，判断是否为空

@end
