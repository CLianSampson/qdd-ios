//
//  EnterpriseVerifyVC.m
//  qdd
//
//  Created by Apple on 17/5/1.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "EnterpriseVerifyVC.h"
#import "PasswordView.h"
#import "GetVerifyCodeView.h"
#import "FaceSucessVC.h"
#import "Constants.h"

@interface EnterpriseVerifyVC()<SendSmsCodeDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)PasswordView *enterpriseName;  //企业名称

@property(nonatomic,strong)PasswordView *enterpriseBankCardNum; //企业对公银行账号

@property(nonatomic,strong)UIButton *enterpriseThreeCertificatButton; //企业三证
@property(nonatomic,strong)UIButton *threeCertificateButton;  //三证合一
@property(nonatomic,strong)UIButton *fiveCertifateButton;  //五证合一


@property(nonatomic,strong)PasswordView *registerNum; //营业执照注册号

@property(nonatomic,strong)PasswordView *organizationCode; //组织机构代码

@property(nonatomic,strong)PasswordView *lawName; //法定代表人姓名

@property(nonatomic,strong)PasswordView *lawIdNum; //法定代表人身份证号

@property(nonatomic,strong)PasswordView *lawPhone; //法定代表人手机号

@property(nonatomic,strong)GetVerifyCodeView *verifyCode; //获取短信验证码

@property(nonatomic,assign)int signType ;//认证类型	0：企业三证1：三证合一2：五证合一

@property(nonatomic,assign)int pictureType; //图片类型 0:证件执照副本图片 ,1组织机构代码图片,2税务登记证,3正面照,4反面照

@property(nonatomic,strong)UIImageView *viceCertificatePicture; //证件执照副本图片

@property(nonatomic,strong)UIImageView *organizationPicture; //组织机构代码图片

@property(nonatomic,strong)UIImageView *taxiPicture; //税务登记证

@property(nonatomic,strong)UIImageView *frontPicture; //正面照

@property(nonatomic,strong)UIImageView *backPicture; //反面照

@property(nonatomic,strong)NSString *viceCertificatePicturePath;  //证件执照副本图片路径

@property(nonatomic,strong)NSString *organizationPicturePath; //组织机构代码图片路径

@property(nonatomic,strong)NSString *taxiPicturePath; //税务登记证路径

@property(nonatomic,strong)NSString *frontPicturePath; //正面照路径

@property(nonatomic,strong)NSString *backPicturePath; //反面照路径

@end

@implementation EnterpriseVerifyVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    [super createNavition];
//    self.mytitle.text=@"实名认证";
//    
//    [self creteView];
    
    _signType = 0;
    
    _pictureType = 0;
    
    _viceCertificatePicturePath = @"";
    _organizationPicturePath = @"";
    _taxiPicturePath = @"";

    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    [self createScrollView];
    
    [self addNotification];
    
}


-(void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
     _scrollView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 460*3+50);
    
    //scrollView添加点击事件回收键盘
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [_scrollView addGestureRecognizer:recognizer];
    
    [self.view addSubview:_scrollView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:self.leftButton];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.leftButton];
    
    self.mytitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    self.mytitle.textAlignment=NSTextAlignmentCenter;
    self.mytitle.font=[UIFont boldSystemFontOfSize:17];
    self.mytitle.text=@"实名认证";

    [_scrollView addSubview:self.mytitle];
    
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44-30*WIDTH_SCALE, 31, 44, 22)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(commitData) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:rightButton];
    
    
    [self creteView];
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
}


-(void)creteView{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    UILabel *verifyType = [[UILabel alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, 67, SCREEN_WIDTH-50*WIDTH_SCALE, 72*HEIGHT_SCALE)];
    verifyType.text = @"认证方式: 银行卡认证";
    verifyType.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:verifyType];
    
    [self createEnterpriecCertificateInformation:verifyType];
}

//企业证件信息
-(void)createEnterpriecCertificateInformation:(UIView *)view{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, (38+26)*HEIGHT_SCALE + 13)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:backGroundView];
    
    UILabel *enterpriseInformation  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 38*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 13)];
    enterpriseInformation.text  = @"企业证件信息";
    enterpriseInformation.font = [UIFont systemFontOfSize:13];
    [_scrollView addSubview:enterpriseInformation];
    
    [self createEnterpriseName:backGroundView];
}


-(void)createEnterpriseName:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _enterpriseName = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _enterpriseName.password.text=@"企业名称";
    _enterpriseName.textField.placeholder=@"请输入企业名称";
    _enterpriseName.password.textColor=RGBColor(51, 51, 51);
    _enterpriseName.textField.textColor=RGBColor(172, 172, 172);
    _enterpriseName.password.font=[UIFont systemFontOfSize:14];
    _enterpriseName.textField.font=[UIFont systemFontOfSize:14];
    [_enterpriseName addSubview:_enterpriseName.cancelButton];
    [_scrollView addSubview:_enterpriseName];
    
    float height = _enterpriseName.frame.origin.y + _enterpriseName.frame.size.height ;
    
    [self createReminderView:height];
    
}

-(void)createReminderView:(float )height{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, (16+26)*HEIGHT_SCALE + 10)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:backGroundView];
    
    UILabel *reminder  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 16*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 10)];
    reminder.text  = @"*    请输入营业执照上的名称";
    reminder.font = [UIFont systemFontOfSize:13];
    reminder.textColor = RGBColor(255, 0, 0);
    [_scrollView addSubview:reminder];

    
    [self createEnterpriseBankCardNum:reminder];
    
}

//企业对公银行账号
-(void)createEnterpriseBankCardNum:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height+26*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _enterpriseBankCardNum = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _enterpriseBankCardNum.password.text=@"企业对公银行账号";
    _enterpriseBankCardNum.textField.placeholder=@"请输入企业对公银行账号";
    _enterpriseBankCardNum.password.textColor=RGBColor(51, 51, 51);
    _enterpriseBankCardNum.textField.textColor=RGBColor(172, 172, 172);
    _enterpriseBankCardNum.password.font=[UIFont systemFontOfSize:12];
    _enterpriseBankCardNum.textField.font=[UIFont systemFontOfSize:12];
    [_enterpriseBankCardNum addSubview:_enterpriseBankCardNum.cancelButton];
    [_scrollView addSubview:_enterpriseBankCardNum];
    
    [self createThreeCertificate:_enterpriseBankCardNum];
}


-(void)createThreeCertificate:(UIView *)view{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 8+10+15+30+20)];
    backgroundView.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:backgroundView];
    
    UILabel *reminder  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 16*HEIGHT_SCALE + backgroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 10)];
    reminder.text  = @"*    请输入营业执照上的名称";
    reminder.font = [UIFont systemFontOfSize:13];
    reminder.textColor = RGBColor(255, 0, 0);
    [_scrollView addSubview:reminder];
    
    float buttonWidth = ( SCREEN_WIDTH - (200+60)*WIDTH_SCALE )/3;
    
    _enterpriseThreeCertificatButton  =  [[UIButton alloc]initWithFrame:CGRectMake(100*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height+15, buttonWidth, 30)];
    [_enterpriseThreeCertificatButton setTitle:@"企业三证" forState:UIControlStateNormal];
    _enterpriseThreeCertificatButton.backgroundColor = BlueRGBColor;
    _enterpriseThreeCertificatButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _enterpriseThreeCertificatButton.layer.cornerRadius = 5;
    [_enterpriseThreeCertificatButton addTarget:self action:@selector(enterpriseThreeClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_enterpriseThreeCertificatButton];
    
    
    _threeCertificateButton = [[UIButton alloc]initWithFrame:CGRectMake(_enterpriseThreeCertificatButton.frame.origin.x+_enterpriseThreeCertificatButton.frame.size.width+30*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height+15, buttonWidth, 30)];
    [_threeCertificateButton setTitle:@"三证合一" forState:UIControlStateNormal];
    _threeCertificateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _threeCertificateButton.layer.cornerRadius = 5;
    _threeCertificateButton.backgroundColor = [UIColor whiteColor];
    _threeCertificateButton.layer.borderWidth = 1;
    _threeCertificateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_threeCertificateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    [_threeCertificateButton addTarget:self action:@selector(threeClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_threeCertificateButton];
    
    _fiveCertifateButton = [[UIButton alloc]initWithFrame:CGRectMake(_threeCertificateButton.frame.origin.x+_threeCertificateButton.frame.size.width+30*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height+15, buttonWidth, 30)];
    [_fiveCertifateButton setTitle:@"五证合一" forState:UIControlStateNormal];
    _fiveCertifateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _fiveCertifateButton.layer.cornerRadius = 5;
    _fiveCertifateButton.backgroundColor = [UIColor whiteColor];
    _fiveCertifateButton.layer.borderWidth = 1;
    _fiveCertifateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_fiveCertifateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    [_fiveCertifateButton addTarget:self action:@selector(fiveClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_fiveCertifateButton];

    
    [self createRegisterNum:backgroundView];
    
}

//营业执照注册号
-(void)createRegisterNum:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _registerNum = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _registerNum.password.text=@"营业执照注册号";
    _registerNum.textField.placeholder=@"请输入营业执照注册号";
    _registerNum.password.textColor=RGBColor(51, 51, 51);
    _registerNum.textField.textColor=RGBColor(172, 172, 172);
    _registerNum.password.font=[UIFont systemFontOfSize:12];
    _registerNum.textField.font=[UIFont systemFontOfSize:12];
    [_registerNum addSubview:_registerNum.cancelButton];
    [_scrollView addSubview:_registerNum];
    
    //营业执照注册号 －－－－－ 证件执照副本图片
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _registerNum.frame.origin.y+_registerNum.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];

    [self createCertificatePicture:background1];


}

//证件执照副本图片
-(void)createCertificatePicture:(UIView *)view{
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 86*HEIGHT_SCALE)];
    text.text = @"证件执照副本图片";
    text.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:text];
    
    _viceCertificatePicture = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    _viceCertificatePicture.layer.borderWidth = 1;
    _viceCertificatePicture.layer.borderColor = BlueRGBColor.CGColor;
    _viceCertificatePicture.layer.cornerRadius = 5;
    _viceCertificatePicture.userInteractionEnabled = YES;
    [_scrollView addSubview:_viceCertificatePicture];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_viceCertificatePicture.frame.size.width/2-6, _viceCertificatePicture.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addViceCertificatePictureClick) forControlEvents:UIControlEventTouchUpInside];
    [_viceCertificatePicture addSubview:button];
    
    //证件执照副本图片 －－－－－ 组织机构代码
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _viceCertificatePicture.frame.origin.y+_viceCertificatePicture.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];



    [self createOrganizationCode:background1];
   
}


 //组织机构代码
-(void)createOrganizationCode:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _organizationCode = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _organizationCode.password.text=@"组织机构代码";
    _organizationCode.textField.placeholder=@"请输入组织机构代码";
    _organizationCode.password.textColor=RGBColor(51, 51, 51);
    _organizationCode.textField.textColor=RGBColor(172, 172, 172);
    _organizationCode.password.font=[UIFont systemFontOfSize:12];
    _organizationCode.textField.font=[UIFont systemFontOfSize:12];
    [_organizationCode addSubview:_organizationCode.cancelButton];
    [_scrollView addSubview:_organizationCode];
    
    //组织机构代码 －－－－－ 组织机构代码证
    UIView *background2 = [[UIView alloc]initWithFrame:CGRectMake(0, _organizationCode.frame.origin.y+_organizationCode.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background2.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background2];
    
    
    [self createCodePicture:background2];

}

//组织机构代码证
-(void)createCodePicture:(UIView *)view{
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 86*HEIGHT_SCALE)];
    text.text = @"组织机构代码证";
    text.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:text];
    
    _organizationPicture = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    _organizationPicture.layer.borderWidth = 1;
    _organizationPicture.layer.borderColor = BlueRGBColor.CGColor;
    _organizationPicture.layer.cornerRadius = 5;
    _organizationPicture.userInteractionEnabled = YES;
    [_scrollView addSubview:_organizationPicture];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_organizationPicture.frame.size.width/2-6, _organizationPicture.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addOrganizationPicture) forControlEvents:UIControlEventTouchUpInside];
    [_organizationPicture addSubview:button];
    
    //组织机构代码证 －－－－－ 税务登记证
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _organizationPicture.frame.origin.y+_organizationPicture.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];
    
    [self createSignCertificate:background1];
}


//税务登记证
-(void)createSignCertificate:(UIView *)view{
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 86*HEIGHT_SCALE)];
    text.text = @"税务登记证";
    text.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:text];
    
    _taxiPicture = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    _taxiPicture.layer.borderWidth = 1;
    _taxiPicture.layer.borderColor = BlueRGBColor.CGColor;
    _taxiPicture.layer.cornerRadius = 5;
    _taxiPicture.userInteractionEnabled = YES;
    [_scrollView addSubview:_taxiPicture];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_taxiPicture.frame.size.width/2-6, _taxiPicture.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addTaxiPicture) forControlEvents:UIControlEventTouchUpInside];
    [_taxiPicture addSubview:button];
    
   
    
    [self createLawInformation:_taxiPicture];

}

//法定代表人信息
-(void)createLawInformation:(UIView *)view{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, (38+26)*HEIGHT_SCALE + 13)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:backGroundView];
    
    UILabel *enterpriseInformation  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 38*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 13)];
    enterpriseInformation.text  = @"法定代表人信息";
    enterpriseInformation.font = [UIFont boldSystemFontOfSize:13];
    [_scrollView addSubview:enterpriseInformation];
    
    
    [self createLawName:backGroundView];
}


//法定代表人姓名
-(void)createLawName:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _lawName = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _lawName.password.text=@"法定代表人姓名";
    _lawName.textField.placeholder=@"请输入法定代表人姓名";
    _lawName.password.textColor=RGBColor(51, 51, 51);
    _lawName.textField.textColor=RGBColor(172, 172, 172);
    _lawName.password.font=[UIFont systemFontOfSize:14];
    _lawName.textField.font=[UIFont systemFontOfSize:14];
    [_lawName addSubview:_lawName.cancelButton];
    [_scrollView addSubview:_lawName];
    
    
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _lawName.frame.origin.y+_lawName.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];

    [self createLawIdNum:background1];
}


//法定代表人身份证号
-(void)createLawIdNum:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _lawIdNum = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _lawIdNum.password.text=@"法定代表人身份证";
    _lawIdNum.textField.placeholder=@"请输入法定代表人身份证号";
    _lawIdNum.password.textColor=RGBColor(51, 51, 51);
    _lawIdNum.textField.textColor=RGBColor(172, 172, 172);
    _lawIdNum.password.font=[UIFont systemFontOfSize:12];
    _lawIdNum.textField.font=[UIFont systemFontOfSize:12];
    [_lawIdNum addSubview:_lawIdNum.cancelButton];
    [_scrollView addSubview:_lawIdNum];
    
    
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _lawIdNum.frame.origin.y+_lawIdNum.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];
    
    [self createLawPicture:background1];
}


//法人手持证件照
-(void)createLawPicture:(UIView *)view{
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 86*HEIGHT_SCALE)];
    text.text = @"法人手持证件照";
    text.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:text];
    
    _frontPicture = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    _frontPicture.layer.borderWidth = 1;
    _frontPicture.layer.borderColor = BlueRGBColor.CGColor;
    _frontPicture.layer.cornerRadius = 5;
    _frontPicture.userInteractionEnabled = YES;
    [_scrollView addSubview:_frontPicture];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_frontPicture.frame.size.width/2-6, _frontPicture.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addFrontPicture) forControlEvents:UIControlEventTouchUpInside];
    [_frontPicture addSubview:button];
    
    UILabel *information = [[UILabel alloc]initWithFrame:CGRectMake(_frontPicture.frame.size.width/2-100, button.frame.origin.y+button.frame.size.height+10, 200, 10)];
    information.text = @"上传正面照证件";
    information.textColor = GrayRGBColor;
    information.textAlignment = NSTextAlignmentCenter;
    information.font  = [UIFont systemFontOfSize:10];
    [_frontPicture addSubview:information];
    
    _backPicture = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, _frontPicture.frame.origin.y+_frontPicture.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    _backPicture.layer.borderWidth = 1;
    _backPicture.layer.borderColor = BlueRGBColor.CGColor;
    _backPicture.layer.cornerRadius = 5;
    _backPicture.userInteractionEnabled = YES;
    [_scrollView addSubview:_backPicture];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(_backPicture.frame.size.width/2-6, _backPicture.frame.size.height/2-6, 16, 12)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addBackPicture) forControlEvents:UIControlEventTouchUpInside];
    [_backPicture addSubview:button1];
    
    UILabel *information1 = [[UILabel alloc]initWithFrame:CGRectMake(_backPicture.frame.size.width/2-100, button1.frame.origin.y+button1.frame.size.height+10, 200, 10)];
    information1.text = @"上传反面照证件";
    information1.textColor = GrayRGBColor;
    information1.textAlignment = NSTextAlignmentCenter;
    information1.font = [UIFont systemFontOfSize:10];
    [_backPicture addSubview:information1];

    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _backPicture.frame.origin.y+_backPicture.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];

    [self createPhone:background1];
}

//法定代表人手机号
-(void)createPhone:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _lawPhone = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _lawPhone.password.text=@"法定代表人手机号";
    _lawPhone.textField.placeholder=@"请输入法定代表人手机号";
    _lawPhone.password.textColor=RGBColor(51, 51, 51);
    _lawPhone.textField.textColor=RGBColor(172, 172, 172);
    _lawPhone.password.font=[UIFont systemFontOfSize:12];
    _lawPhone.textField.font=[UIFont systemFontOfSize:13];
    [_lawPhone addSubview:_lawPhone.cancelButton];
    _lawPhone.textField.delegate = self;
    [_scrollView addSubview:_lawPhone];
    
    
    _verifyCode = [[GetVerifyCodeView alloc]initWithFrame:CGRectMake(0, _lawPhone.frame.origin.y+_lawPhone.frame.size.height, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _verifyCode.delegate=self;
    _verifyCode.textField.delegate = self;
    [_scrollView addSubview:_verifyCode];

}



#pragma mark  sendSmsCode delegate
-(void)sendSmsCode{
    
    
    if (_lawPhone.textField.text==nil
        || [StringUtil isNullOrBlank:_lawPhone.textField.text]) {
        [self createAlertView];
        self.alertView.title=@"手机号不能为空";
        [self.alertView show];
        
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SMS];
    NSString *urlParameters=[NSString stringWithFormat:@"mobile=%@",_lawPhone.textField.text];
    
    [urlstring appendString:urlParameters];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
    };
    
    request.netFailedBlock=^(id result){
        
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };

    
    [request netRequestGetWithUrl:urlstring Data:nil];
}


#pragma mark scrollview添加点击事件回收键盘
- (void)touchScrollView{
    [_organizationCode.textField resignFirstResponder];
    
    [_registerNum.textField resignFirstResponder];
    
    [_enterpriseBankCardNum.textField resignFirstResponder];
    
    [_lawIdNum.textField resignFirstResponder];
    
    [_enterpriseName.textField resignFirstResponder];
    
    [_lawPhone.textField resignFirstResponder];
    
    [_lawName.textField resignFirstResponder];
    
    [_verifyCode.textField resignFirstResponder];
    
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark uitextfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollView.frame = CGRectMake(0, -200, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark 三证合一点击事件
-(void)enterpriseThreeClick{
    _signType = 0;
   
    _enterpriseThreeCertificatButton.backgroundColor = BlueRGBColor;
    _enterpriseThreeCertificatButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _enterpriseThreeCertificatButton.layer.cornerRadius = 5;
    [_enterpriseThreeCertificatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
   
    _threeCertificateButton.backgroundColor = [UIColor whiteColor];
    _threeCertificateButton.layer.borderWidth = 1;
    _threeCertificateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_threeCertificateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
   
    _fiveCertifateButton.backgroundColor = [UIColor whiteColor];
    _fiveCertifateButton.layer.borderWidth = 1;
    _fiveCertifateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_fiveCertifateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];

}


-(void)threeClick{
    _signType = 1;
    
    _threeCertificateButton.backgroundColor = BlueRGBColor;
    _threeCertificateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _threeCertificateButton.layer.cornerRadius = 5;
    [_threeCertificateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    _enterpriseThreeCertificatButton.backgroundColor = [UIColor whiteColor];
    _enterpriseThreeCertificatButton.layer.borderWidth = 1;
    _enterpriseThreeCertificatButton.layer.borderColor = BlueRGBColor.CGColor;
    [_enterpriseThreeCertificatButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    
    _fiveCertifateButton.backgroundColor = [UIColor whiteColor];
    _fiveCertifateButton.layer.borderWidth = 1;
    _fiveCertifateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_fiveCertifateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
}

-(void)fiveClick{
    _signType = 2;
    
    _fiveCertifateButton.backgroundColor = BlueRGBColor;
    _fiveCertifateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _fiveCertifateButton.layer.cornerRadius = 5;
    [_fiveCertifateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    
    
    _threeCertificateButton.backgroundColor = [UIColor whiteColor];
    _threeCertificateButton.layer.borderWidth = 1;
    _threeCertificateButton.layer.borderColor = BlueRGBColor.CGColor;
    [_threeCertificateButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    
    _enterpriseThreeCertificatButton.backgroundColor = [UIColor whiteColor];
    _enterpriseThreeCertificatButton.layer.borderWidth = 1;
    _enterpriseThreeCertificatButton.layer.borderColor = BlueRGBColor.CGColor;
    [_enterpriseThreeCertificatButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
}


//添加照片
#pragma mark 上传证件执照副本图片
-(void)addViceCertificatePictureClick{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"0" forKey:@"type"];
    [self openAblam:dic];
}

#pragma mark 上传组织机构代码证图片
-(void)addOrganizationPicture{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"type"];
    [self openAblam:dic];
}

#pragma mark 上传税务图片
-(void)addTaxiPicture{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"2" forKey:@"type"];
    [self openAblam:dic];
}

#pragma mark 上传正面图片
-(void)addFrontPicture{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"3" forKey:@"type"];
    [self openAblam:dic];
}


#pragma mark 上传反面图片
-(void)addBackPicture{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"type"];
    [self openAblam:dic];
}

-(void)openAblam:(NSMutableDictionary *)dic{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:^{
        NSString *type = [dic objectForKey:@"type"];
        switch ([type intValue]) {
            case 0:
                _pictureType = 0;
                break;
                
            case 1:
                _pictureType = 1;
                break;
                
            case 2:
                _pictureType = 2;
                break;
            
            case 3:
                _pictureType = 3;
                break;

            case 4:
                _pictureType = 4;
                break;
                
            default:
                break;
        }
    }];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        switch (_pictureType) {
            case 0:
                _viceCertificatePicture.image=image;
                [self uploadPicture:_viceCertificatePicture.image];
                break;
                
            case 1:
                _organizationPicture.image = image;
                [self uploadPicture:_organizationPicture.image];
                break;
            
            case 2:
                _taxiPicture.image = image;
                [self uploadPicture:_taxiPicture.image];
                break;
            
            case 3:
                _frontPicture.image = image;
                [self uploadPicture:_frontPicture.image];
                break;
            
            case 4:
                _backPicture.image = image;
                [self uploadPicture:_backPicture.image];
                break;
                
            default:
                break;
        }

    }];
}


-(void)uploadPicture:(UIImage *)image{
    [self.view addSubview:self.indicator];
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_UPLOAD_PICTURE];
    
    [urlstring appendString:self.token];
    
    NSLog(@"appendUrlString is : %@",urlstring);
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf sucessDo:result];
            
        }else if ([state isEqualToString:@"fail"]){
            
            
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
    };
    
    request.netFailedBlock=^(id result){
        
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    
    [request upLoad:urlstring image:image];
}


-(void)sucessDo:(id )result{
    
    [self createAlertView];
    self.alertView.title=@"上传图片成功";
    [self.alertView show];
    
    switch (_pictureType) {
        case 0:
            _viceCertificatePicturePath = [result objectForKey:@"data"];
            break;
            
        case 1:
            _organizationPicturePath = [result objectForKey:@"data"];
            break;
            
        case 2:
            _taxiPicturePath = [result objectForKey:@"data"];
            break;
            
        case 3:
            _frontPicturePath = [result objectForKey:@"data"];
            break;
            
        case 4:
            _backPicturePath = [result objectForKey:@"data"];
            break;
            
        default:
            break;
    }

    return;
    
}


-(void)commitData{
    if (self.token==nil) {
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_ENTERPRISE_VERIFY];
    [urlstring appendString:self.token];

    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    NSString *signType = [NSString stringWithFormat:@"%d",_signType];
    
    if ([StringUtil isNullOrBlank:_enterpriseName.textField.text]
        || [StringUtil isNullOrBlank:_enterpriseBankCardNum.textField.text]
        || [StringUtil isNullOrBlank:_lawName.textField.text]
        || [StringUtil isNullOrBlank:_lawPhone.textField.text]
        || [StringUtil isNullOrBlank:_lawIdNum.textField.text]
        || [StringUtil isNullOrBlank:_verifyCode.textField.text]) {
        
        
        [self createAlertView];
        self.alertView.title=@"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    [dic setObject:_enterpriseName.textField.text forKey:@"name"];
    [dic setObject:_enterpriseBankCardNum.textField.text forKey:@"bankid"];
    [dic setObject:signType forKey:@"siden"];
    
    [dic setObject:_registerNum.textField.text forKey:@"businessid"];
    [dic setObject:_viceCertificatePicturePath forKey:@"businesspath"];
    [dic setObject:_organizationCode.textField.text forKey:@"ocode"];
    [dic setObject:_organizationPicturePath forKey:@"oripath"];
    
    [dic setObject:_taxiPicturePath forKey:@"taxpath"];
    
    /********************************无以下提交参数***************************/
    //统一社会信用代码	string	N	三证合一
    //businesspath3	证件执照副本照片	string	N	三证合一
    //businessid5	统一社会信用代码	string	N	五证合一
    //businesspath5	证件执照副本照片
    
    [dic setObject:_lawName.textField.text forKey:@"sname"];
    [dic setObject:_lawIdNum.textField.text forKey:@"sfz"];
    [dic setObject:_lawPhone.textField.text forKey:@"mobile"];
    [dic setObject:_verifyCode.textField.text forKey:@"mobile_code"];
    
    
    NSLog(@"json data is : %@" ,dic);
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            
            FaceSucessVC *VC =[[FaceSucessVC alloc]init];
            VC.token = weakSelf.token;
            VC.authState = weakSelf.authState;
            VC.verifyState = weakSelf.verifyState;
            VC.accountFlag = weakSelf.accountFlag;
            [weakSelf.navigationController pushViewController:VC animated:YES];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
    };
    
    request.netFailedBlock=^(id result){
        
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestWithUrl:urlstring Data:dic];
}


-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeft) name:GOTO_MAIN_CONTROLLER_FROM_ENTERPRISE_VERIFY_CONTROLLER object:nil];
}




@end














