//
//  BaseVC.h
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetRequest.h"
#import "MJRefresh.h"
#import "StringUtil.h"
#import "TimeUtil.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "math.h"

typedef void (^NetSucessBlock)(id result);
typedef void (^NetFailedBlock)(id result);

typedef void (^PictureBlock)(id result);

typedef void(^BackBlock)(void);


//个人用户还是企业用户
typedef NS_ENUM(NSInteger, ACCOUNT_FLAG) {
    USER_ACCOUNT = 1,
    ENTERPRISE_ACCOUNT =2,
};

//合同状态
typedef NS_ENUM(NSInteger, SIGN_STATE) {
    WAIT_FOR_ME = 1,
    WAIT_FOR_OTHER =2,
    COMPLETE = 3,
    TIME_OUT,
};

//授权状态
typedef NS_ENUM(NSInteger, AUTH_STATE) {
    NOT_AUTH = 1,
    HAVE_AUTH =2,
};


//认证状态  0：未认证  1：审核中  2：审核通过   3：审核不通过
typedef NS_ENUM(NSInteger, VERIFY_STATE) {
    NOT_VERIFY= 0,
    UNDER_VERIFYING =1,
    HAVE_VERIFY = 2,
    NOT_PASS_VERIFY = 3,
};

@interface  BaseVC : UIViewController<UIAlertViewDelegate>



@property(nonatomic,strong)UIAlertView *alertView;


@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel *mytitle;

@property(nonatomic,copy)NetSucessBlock netSucessBlock;
@property(nonatomic,copy)NetFailedBlock netFailedBlock;
@property(nonatomic,copy)PictureBlock pictureBlock;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;

@property(nonatomic,strong)NSString *token;

@property(nonatomic,assign)ACCOUNT_FLAG accountFlag;
@property(nonatomic,assign)AUTH_STATE authState;
@property(nonatomic,assign)VERIFY_STATE verifyState;



-(void)createBackgroungView;

-(void)createAlertView;

-(void)createNavition;

-(void)showLeft;

//-(void)netRequestWithUrl:(NSString *)url Data:(id )data;
//
//-(void)netRequestGetWithUrl:(NSString *)url Data:(id )data;
//
//- (void)downLoad:(NSString *)urlString;

-(void)addLoadIndicator;

//-(void)upLoad:(NSString *)urlString image:(UIImage *)image;

-(void)gotoMainController;

@end
