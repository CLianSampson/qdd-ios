//
//  AFNetRequest.h
//  
//
//  Created by Apple on 16/12/17.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static NSString *URL_COMMON=@"https://www.qiandd.com";

static  NSString *URL_SMS = @"https://www.qiandd.com/mobile/user/sms?"; //短信验证码

static  NSString *URL_REGISTER = @"https://www.qiandd.com/mobile/user/doregister"; //注册

static  NSString *URL_PICTURE_CODE = @"https://www.qiandd.com/api/checkcode/index?length=4&font_size=14&width=100&height=26&charset=1234567890&use_noise=1&use_curve=0"; //图片验证码


static NSString *URL_LOGIN = @"https://www.qiandd.com/mobile/user/dologin"; //登陆

static NSString *URL_LIST_SIGN =@"https://www.qiandd.com/mobile/Contract/index/token/"; //合同列表

static NSString *URL_SIGN_DETAIL=@"https://www.qiandd.com/mobile/Contract/details/token/";//合同内容

static NSString *URL_SIGN_SHOW=@"https://www.qiandd.com/mobile/Contract/sendsign/token/";//合同展示页面


static NSString *URL_LIST_MESSAGE=@"https://www.qiandd.com/mobile/Message/index/token/";//消息列表

static NSString *URL_MESSAGE_DETAIL=@"https://www.qiandd.com/mobile/Message/show/token/";

static NSString *URL_COMMENT=@"https://www.qiandd.com/mobile/Question/add/token/";//意见反馈

//帮助列表
static NSString *URL_LIST_HELP=@"https://www.qiandd.com/mobile/help/lists";

//帮助详情
static NSString *URL_HELP_DETAIL=@"https://www.qiandd.com/mobile/help/show/id/";

static NSString *URL_LIST_ORDER=@"https://www.qiandd.com/mobile/order/allindex/token/";// 订单列表

static NSString *URL_LIST_SIGNATURE=@"https://www.qiandd.com/mobile/Sign/signindex/token/";//签名列表

//添加签名
static NSString *URL_ADD_SIGNATURE=@"https://www.qiandd.com/mobile/Sign/add_post/token/";

//设置默认签章
static NSString *URL_SET_DETAULT_SIGNATURE=@"https://www.qiandd.com/mobile/Sign/mobilesetdefault/token/";

//删除签章
static NSString *URL_DELETE_SLGNATURE=@"https://www.qiandd.com/mobile/Sign/delete/token/";

static NSString *URL_UPLOAD_PICTURE=@"https://www.qiandd.com/mobile/Iden/picupload/token/";//上传图片


static NSString *URL_FORGET_PASSWORD=@"https://www.qiandd.com/mobile/user/do_mobile_forgot_password";//忘记密码

static NSString *URL_RESET_PASSWORD=@"https://www.qiandd.com/mobile/Set/changepwd_post/token/";//修改密码

static NSString *URL_GET_ACCOUNT_INFO=@"https://www.qiandd.com/mobile/set/userinfo/token/";//获取用户资料

static NSString *URL_BIND_MAIL=@"https://www.qiandd.com/mobile/Set/bound_post/token/";//绑定邮箱，发送邮件


//删除修改手机号（验证验证码） 设置里
static NSString *URL_CHANGE_PHONE=@"https://www.qiandd.com/mobile/Set/refre_post/token/";

static NSString *URL_LIST_CONTACT=@"https://www.qiandd.com/mobile/Contacts/index/token/";//联系人列表


//搜索联系人
static NSString *URL_SEARCH_USER=@"https://www.qiandd.com/mobile/Contacts/search/token/";

//添加联系人
static NSString *URL_ADD_USER=@"https://www.qiandd.com/mobile/Contacts/add/token/";

//个人认证
static NSString *URL_USER_VERIFY=@"https://www.qiandd.com/mobile/Iden/iden_post/token/";

//企业认证
static NSString *URL_ENTERPRISE_VERIFY=@"https://www.qiandd.com/mobile/Iden/comiden_post/token/";

//判断用户是否授权
static NSString *URL_IS_AUTH=@"https://www.qiandd.com/mobile/Contract/auth/token/";


//撤销合同
static NSString *URL_REFUSE_SIGN=@"https://www.qiandd.com/mobile/Contract/repeal/token/";

//合同签署时签章列表
static NSString *URL_LIST_SIGN_SIGNATURE=@"https://www.qiandd.com/mobile/Contract/getsign/token/";

//获取用户手机号
static NSString *URL_GET_USER_PHONE=@"https://www.qiandd.com/mobile/Contract/change/token/";

//获取签合同时短信验证码
static NSString *URL_SIGN_GET_SMS_CODE=@"https://www.qiandd.com/mobile/Contract/sms/token/";

//验证手机验证码
static NSString *URL_VERIFY_MOBILE_CODE=@"https://www.qiandd.com/mobile/Contract/refre_post/token/";

//存储删除合同签章信息
static NSString *URL_STORE_AND_DELETE_SIGNATURE=@"https://www.qiandd.com/mobile/Contract/contract_sign/token/";

//设置合同签署类型  (没有用到)
static NSString *URL_SET_SIGN_TYPE=@"https://www.qiandd.com/mobile/Contract/setstatus/token/";

//签合同
static NSString *URL_SIGN_SIGNATURE=@"https://www.qiandd.com/mobile/Contract/signend/token/";

//购买合同(我的套餐)
static NSString *URL_BUY_GOODS=@"https://www.qiandd.com/mobile/goods/goodsindex/token/";

//套餐详情
static NSString *URL_GOODS_DETAIL=@"https://www.qiandd.com/mobile/goods/goods/token/";

//获取订单号
static NSString *URL_GET_ORDERID=@"https://www.qiandd.com/mobile/goods/orderinfo/token/";

//微信支付，获取prepayid
static NSString *URL_WXPAY=@"https://www.qiandd.com/mobile/pays/wxpay/token/";

//支付宝支付，获取tradeno
static NSString *URL_AILPAY=@"https://www.qiandd.com/mobile/pays/alipay/token/";

typedef void (^PictureBlock)(id result);
typedef void(^PictureFailedBlock)();

typedef void (^NetSucessBlock)(id result);
typedef void (^NetFailedBlock)(id result);



@interface AFNetRequest : NSObject

@property(nonatomic,copy)PictureBlock pictureBlock;
@property(nonatomic,copy)PictureFailedBlock pictureFailedBlock;

@property(nonatomic,copy)NetSucessBlock netSucessBlock;
@property(nonatomic,copy)NetFailedBlock netFailedBlock;


- (void)downLoad:(NSString *)urlString;

- (void)upLoad:(NSString *)urlString image:(UIImage *)image;

-(void)downLoadPicture:(NSString *)urlString;


-(void)netRequestWithUrl:(NSString *)url Data:(id )data;

//针对支付宝单独一个接口
-(void)netAlipay:(NSString *)url Data:(id )data;

-(void)netRequestGetWithUrl:(NSString *)url Data:(id )data;

@end




