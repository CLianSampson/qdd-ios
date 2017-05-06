//
//  EnterpriseVerifyVC.m
//  qdd
//
//  Created by Apple on 17/5/1.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "EnterpriseVerifyVC.h"
#import "PasswordView.h"

@interface EnterpriseVerifyVC()

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)PasswordView *enterpriseName;

@property(nonatomic,strong)UIButton *enterpriseThreeCertificatButton; //企业三证
@property(nonatomic,strong)UIButton *threeCertificateButton;  //三证合一
@property(nonatomic,strong)UIButton *fiveCertifateButton;  //五证合一


@property(nonatomic,strong)PasswordView *lawName; //法定代表人姓名

@property(nonatomic,strong)PasswordView *lawPhone; //法定代表人手机号

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
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    [self createScrollView];
    
}


-(void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
     _scrollView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 460*10);
    
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
    
    
    UILabel *bankAccount = [[UILabel alloc]initWithFrame:CGRectMake(50*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 120*HEIGHT_SCALE)];
    bankAccount.text = @"企业对公银行账号";
    bankAccount.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:bankAccount];
    
    [self createThreeCertificate:bankAccount];
    
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
    [_scrollView addSubview:_enterpriseThreeCertificatButton];
    
    
    _threeCertificateButton = [[UIButton alloc]initWithFrame:CGRectMake(_enterpriseThreeCertificatButton.frame.origin.x+_enterpriseThreeCertificatButton.frame.size.width+30*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height+15, buttonWidth, 30)];
    [_threeCertificateButton setTitle:@"三证合一" forState:UIControlStateNormal];
    _threeCertificateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_scrollView addSubview:_threeCertificateButton];
    
    _fiveCertifateButton = [[UIButton alloc]initWithFrame:CGRectMake(_threeCertificateButton.frame.origin.x+_threeCertificateButton.frame.size.width+30*WIDTH_SCALE, reminder.frame.origin.y+reminder.frame.size.height+15, buttonWidth, 30)];
    [_fiveCertifateButton setTitle:@"五证合一" forState:UIControlStateNormal];
    _fiveCertifateButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_scrollView addSubview:_fiveCertifateButton];
    
    
    
    //营业执照注册号
    UILabel *enterpriseAccount = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, backgroundView.frame.origin.y+backgroundView.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 120*HEIGHT_SCALE)];
    enterpriseAccount.text = @"营业执照注册号";
    enterpriseAccount.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:enterpriseAccount];
    
    
    //营业执照注册号 －－－－－ 证件执照副本图片
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, enterpriseAccount.frame.origin.y+enterpriseAccount.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = BlueRGBColor.CGColor;
    imageView.layer.cornerRadius = 5;
//    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [_scrollView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width/2-6, imageView.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [imageView addSubview:button];
    
    //证件执照副本图片 －－－－－ 组织机构代码
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];


    
    //组织机构代码
    UILabel *code = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, background1.frame.origin.y+background1.frame.size.height, SCREEN_WIDTH-50*WIDTH_SCALE, 120*HEIGHT_SCALE)];
    code.text = @"组织机构代码";
    code.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:code];
    
    
    //组织机构代码 －－－－－ 组织机构代码证
    UIView *background2 = [[UIView alloc]initWithFrame:CGRectMake(0, code.frame.origin.y+code.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = BlueRGBColor.CGColor;
    imageView.layer.cornerRadius = 5;
    //    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [_scrollView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width/2-6, imageView.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [imageView addSubview:button];
    
    //组织机构代码证 －－－－－ 税务登记证
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];
    
    [self createLawInformation:background1];
}


//法定代表人信息
-(void)createLawInformation:(UIView *)view{
    UIView *backGroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, (38+26)*HEIGHT_SCALE + 13)];
    backGroundView.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:backGroundView];
    
    UILabel *enterpriseInformation  = [[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, 38*HEIGHT_SCALE + backGroundView.frame.origin.y, SCREEN_WIDTH-36*WIDTH_SCALE, 13)];
    enterpriseInformation.text  = @"法定代表人信息";
    enterpriseInformation.font = [UIFont systemFontOfSize:13];
    [_scrollView addSubview:enterpriseInformation];
    
    [self createLawName:view];
}


//法定代表人姓名
-(void)createLawName:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _enterpriseName = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _enterpriseName.password.text=@"法定代表人姓名";
    _enterpriseName.textField.placeholder=@"请输入法定代表人姓名";
    _enterpriseName.password.textColor=RGBColor(51, 51, 51);
    _enterpriseName.textField.textColor=RGBColor(172, 172, 172);
    _enterpriseName.password.font=[UIFont systemFontOfSize:14];
    _enterpriseName.textField.font=[UIFont systemFontOfSize:14];
    [_enterpriseName addSubview:_enterpriseName.cancelButton];
    [_scrollView addSubview:_enterpriseName];
    
    
    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, _enterpriseName.frame.origin.y+_enterpriseName.frame.size.height, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, text.frame.origin.y+text.frame.size.height, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = BlueRGBColor.CGColor;
    imageView.layer.cornerRadius = 5;
    [_scrollView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width/2-6, imageView.frame.size.height/2-6, 16, 12)];
    [button setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [imageView addSubview:button];
    
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, imageView.frame.origin.y+imageView.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH-36*2*WIDTH_SCALE, 186*HEIGHT_SCALE)];
    imageView1.layer.borderWidth = 1;
    imageView1.layer.borderColor = BlueRGBColor.CGColor;
    imageView1.layer.cornerRadius = 5;
    [_scrollView addSubview:imageView1];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(imageView1.frame.size.width/2-6, imageView1.frame.size.height/2-6, 16, 12)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"添加照片按钮"] forState:UIControlStateNormal];
    [imageView1 addSubview:button1];

    UIView *background1 = [[UIView alloc]initWithFrame:CGRectMake(0, imageView1.frame.origin.y+imageView1.frame.size.height+38*HEIGHT_SCALE, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    background1.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:background1];

    [self createPhone:background1];
}

//法定代表人手机号
-(void)createPhone:(UIView *)view{
    UIView *upperSepreate = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor = SepreateRGBColor;
    [_scrollView addSubview:upperSepreate];
    
    
    _enterpriseName = [[PasswordView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 108*HEIGHT_SCALE)];
    _enterpriseName.password.text=@"法定代表人手机号";
    _enterpriseName.textField.placeholder=@"请输入法定代表人手机号";
    _enterpriseName.password.textColor=RGBColor(51, 51, 51);
    _enterpriseName.textField.textColor=RGBColor(172, 172, 172);
    _enterpriseName.password.font=[UIFont systemFontOfSize:14];
    _enterpriseName.textField.font=[UIFont systemFontOfSize:14];
    [_enterpriseName addSubview:_enterpriseName.cancelButton];
    [_scrollView addSubview:_enterpriseName];
    

}

@end














