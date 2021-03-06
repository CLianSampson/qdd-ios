//
//  RegisteVC.m
//  qdd
//
//  Created by Apple on 17/3/8.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RegisteVC.h"
#import "Macro.h"
#import "RegisteCell.h"
#import "UILabel+Adjust.h"
#import "RegisteSucessVC.h"
#import "RegisteFailedVC.h"
#import "BindMailVC.h"
#import "AFNetRequest.h"
#import "StringUtil.h"

@interface RegisteVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UIButton *personal;
@property(nonatomic,strong)UIButton *enterprise;
@property(nonatomic ,strong)UIView *flagView;

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,assign)int flag;//1代表个人注册，2代表企业注册

//@property(nonatomic,strong)NSString *account;
//@property(nonatomic,strong)NSString *password;
//@property(nonatomic,strong)NSString *verifyCode;
//@property(nonatomic,strong)NSString *repassword;


@property(nonatomic,strong)UIImage *verifyCodeImage;

@property(nonatomic,strong)NSIndexPath *indexPathPhone; //用来获取手机号的值
@property(nonatomic,strong)NSIndexPath *indexPathSmsCode;
@property(nonatomic,strong)NSIndexPath *indexPathPassword;
@property(nonatomic,strong)NSIndexPath *indexPathRepassword;


@end

@implementation RegisteVC




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _flag = 1;
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"注册";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self creteView];
    
}
    
    
    
-(void)creteView{
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 66+49, SCREEN_WIDTH, SCREEN_HEIGHT-66-49)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
    
    _personal = [[UIButton alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH/2, 49)];
    [_personal setTitle:@"个人账户" forState:UIControlStateNormal];
    [_personal setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    _personal.titleLabel.font=[UIFont systemFontOfSize:15];
    [_personal addTarget:self action:@selector(personalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_personal];
    
    _enterprise = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 65, SCREEN_WIDTH/2, 49)];
    [_enterprise setTitle:@"企业账号" forState:UIControlStateNormal];
    [_enterprise setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    _enterprise.titleLabel.font=[UIFont systemFontOfSize:13];
    [_enterprise addTarget:self action:@selector(enterpriseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterprise];
    
    _flagView =[[UIView alloc]initWithFrame:CGRectMake(0, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2)];
    _flagView.backgroundColor=RGBColor(0, 51, 102);
    [self.view addSubview:_flagView];
    
    
    [self createTableView];
}


-(void)createTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _flagView.frame.origin.y+_flagView.frame.size.height+19*HEIGHT_SCALE, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    [self.view addSubview:_myTableView];
    
    UILabel *remind = [[UILabel alloc]initWithFrame:CGRectMake(27*HEIGHT_SCALE, _myTableView.frame.origin.y+_myTableView.frame.size.height+16*HEIGHT_SCALE, SCREEN_WIDTH, 10)];
    remind.text=@"提示: 密码为8－16位的字母，数字组合";
    remind.font=[UIFont systemFontOfSize:10];
    remind.textColor=RGBColor(246, 0, 0);
    [self.view addSubview:remind];
    
    UIButton *choose = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, remind.frame.origin.y+remind.frame.size.height+30*HEIGHT_SCALE, 10, 10)];
//    [choose setBackgroundImage:[UIImage imageNamed:@"阅读选中按钮"] forState:UIControlStateNormal];
    [choose setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    [self.view addSubview:choose];
    
    UILabel *agreeLabel =[[UILabel alloc]initWithFrame:CGRectMake(choose.frame.origin.x+choose.frame.size.width+20*WIDTH_SCALE, remind.frame.origin.y+remind.frame.size.height+30*HEIGHT_SCALE, 100, 10)];
    agreeLabel.text=@"已阅读并同意";
    agreeLabel.font=[UIFont systemFontOfSize:10];
    float width = [UILabel getWidthWithTitle:agreeLabel.text font:agreeLabel.font];
    agreeLabel.frame=CGRectMake(choose.frame.origin.x+choose.frame.size.width+20*WIDTH_SCALE, remind.frame.origin.y+remind.frame.size.height+30*HEIGHT_SCALE, width, 10);
    agreeLabel.textColor=RGBColor(158, 158, 158);
    [self.view addSubview:agreeLabel];
    
    
    
    UILabel *signMuchMuch =[[UILabel alloc]initWithFrame:CGRectMake(agreeLabel.frame.origin.x+agreeLabel.frame.size.width+10*WIDTH_SCALE, remind.frame.origin.y+remind.frame.size.height+30*HEIGHT_SCALE, 200, 10)];
    signMuchMuch.text=@"<<签多多使用协议>>";
    signMuchMuch.textColor=RGBColor(0, 128, 255);
    signMuchMuch.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:signMuchMuch];
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-678*WIDTH_SCALE/2, signMuchMuch.frame.origin.y+signMuchMuch.frame.size.height+30*HEIGHT_SCALE, 678*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    confirm.layer.cornerRadius=5;
    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
}





#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (RegisteCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    RegisteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[RegisteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if (_flag==1) {
        //个人用户
        if (indexPath.row==0) {
            cell.icon.image=[UIImage imageNamed:@"Phone-副本-2"];
            cell.textField.placeholder=@"请输入手机号";
            
            _indexPathPhone = indexPath;

        }else if (indexPath.row==1){
            cell.icon.image=[UIImage imageNamed:@"手机验证码箭头"];
            cell.textField.placeholder=@"手机验证码";
            [cell addSubview:cell.smsCode];
            
            [cell.change removeFromSuperview];
            [cell.verfyCode removeFromSuperview];
            
            _indexPathSmsCode = indexPath;
            
            cell.smsCodeBlock=^{
                [self sendSmsCode];
            };
        }
    }else if (_flag==2){
        //企业用户
        if (indexPath.row==0) {
            cell.icon.image=[UIImage imageNamed:@"Phone-副本-2"];
            cell.textField.placeholder=@"请输入邮箱";
            
            _indexPathPhone = indexPath;
            
        }else if (indexPath.row==1){
            cell.icon.image=[UIImage imageNamed:@"手机验证码箭头"];
            cell.textField.placeholder=@"请输入验证码";
            [cell addSubview:cell.verfyCode];
            [cell addSubview:cell.change];
            
            
//            cell.verfyCode.image=_verifyCodeImage;
            [cell.verfyCode setBackgroundImage:_verifyCodeImage forState:UIControlStateNormal];
            
            [cell.smsCode removeFromSuperview];
            
            _indexPathSmsCode = indexPath;
            
            cell.pictureCodeBlock=^{
                [self sendPictureCode];
            };
        }

    }
    
    
    
    
    if (indexPath.row==2) {
        cell.icon.image=[UIImage imageNamed:@"hover"];
        cell.textField.placeholder=@"请输入密码";
        
        cell.textField.secureTextEntry = YES;

        _indexPathPassword = indexPath;
        
    }else if (indexPath.row==3){
        cell.icon.image=[UIImage imageNamed:@"hover-副本"];
        cell.textField.placeholder=@"请再次输入密码";
        
        cell.textField.secureTextEntry = YES;

        _indexPathRepassword = indexPath;

    }
    
    
    
    return cell;
}


#pragma mark -tableView delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    RegisteCell *cell ;
//    switch (indexPath.row) {
//        case 0:
//            cell = (RegisteCell*)[tableView cellForRowAtIndexPath:indexPath];
//            _account = cell.textField.text;
//            break;
//        
//        case 1:
//            cell = (RegisteCell*)[tableView cellForRowAtIndexPath:indexPath];
//            _verifyCode = cell.textField.text;
//            break;
//            
//        case 2:
//            cell = (RegisteCell*)[tableView cellForRowAtIndexPath:indexPath];
//            _password = cell.textField.text;
//            break;
//            
//        case 3:
//            cell = (RegisteCell*)[tableView cellForRowAtIndexPath:indexPath];
//            _repassword = cell.textField.text;
//            break;
//            
//        default:
//            break;
//    }
//    
//    return;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


//取消键盘第一响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arry = [_myTableView visibleCells];
//
//    for (int i=0; i<[arry count]; i++) {
//        RegisteCell *cell = (RegisteCell*)arry[i];
//        [cell.textField resignFirstResponder];
//        
//        switch (i) {
//            case 0:
//                 _account = cell.value;
//                break;
//                
//            case 1:
//                _verifyCode = cell.value;
//                break;
//            case 2:
//                _password = cell.value;
//                break;
//            case 3:
//                _repassword = cell.value;
//                break;
//                
//            default:
//                break;
//        }
//        
//    }
    
    
    
    for (id object in arry) {
        RegisteCell *cell = (RegisteCell*)object;
        [cell.textField resignFirstResponder];
        
    }
}


-(void)personalClick{
    [self clearData];
    
    [UIView animateWithDuration:0.5 animations:^{
        _flagView.frame=CGRectMake(0, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2);
    }];
     [_personal setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
       [_enterprise setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    _flag=1;
    [_myTableView reloadData];
}


-(void)enterpriseClick{
    [self clearData];
    
    [UIView animateWithDuration:0.5 animations:^{
        _flagView.frame=CGRectMake(SCREEN_WIDTH/2, _personal.frame.origin.y+_personal.frame.size.height+1, SCREEN_WIDTH/2, 2);
    }];
    [_enterprise setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    [_personal setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    _flag=2;
    
    [self sendPictureCode];
    [_myTableView reloadData];
}

//清空原数据
-(void)clearData{
    RegisteCell *phoneCell = [_myTableView cellForRowAtIndexPath:_indexPathPhone];
    RegisteCell *verifyCodeCell = [_myTableView cellForRowAtIndexPath:_indexPathSmsCode];
    RegisteCell *passwordCell = [_myTableView cellForRowAtIndexPath:_indexPathPassword];
    RegisteCell *repasswordCell = [_myTableView cellForRowAtIndexPath:_indexPathRepassword];

    phoneCell.textField.text=nil;
    verifyCodeCell.textField.text=nil;
    passwordCell.textField.text=nil;
    repasswordCell.textField.text=nil;
}

-(void)confirmClick{
    
    if (_flag == 2) {
        //跳转到企业
        
        [self netRequest];
        
//        if ([_account isEqualToString:@"123@qq.com"] && [_password isEqualToString:@"234"]) {
//            
//            BindMailVC *VC = [[BindMailVC alloc]init];
//            
//            VC.mailAccount = _account;
//            
//            [self.navigationController pushViewController:VC animated:YES];
//        }else{
//            RegisteFailedVC *VC = [[RegisteFailedVC alloc]init];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//        
        return;

    }
    
    [self netRequest];
    
//    if ([_account isEqualToString:@"123@qq.com"] && [_password isEqualToString:@"234"]) {
//        RegisteSucessVC *VC = [[RegisteSucessVC alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        RegisteFailedVC *VC = [[RegisteFailedVC alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }

    
    
}


-(void)showLeft{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//注册时获取短信验证码，如果注册过则提示已注册过，不发短信
-(void)sendSmsCode{
    NSString *account;
    if (_flag==1) {
        
        RegisteCell *cell = [_myTableView cellForRowAtIndexPath:_indexPathPhone];
        account = cell.textField.text;
        if ([StringUtil isNullOrBlank:account]) {
            [self createAlertView];
            self.alertView.title=@"手机号不能为空";
            [self.alertView show];
            
            return;
        }
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_REGISTER_SMS];
    NSString *urlParameters=[NSString stringWithFormat:@"mobile=%@",account];
    
    [urlstring appendString:urlParameters];
    
    __weak typeof(self) weakSelf=self;

    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
      
        if ([state isEqualToString:@"success"]) {
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }

        
    };
    
    NSLog(@"注册时获取短信验证码 : %@",urlstring);
    
    [request netRequestGetWithUrl:urlstring Data:nil];
}

-(void)sendPictureCode{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    __weak typeof(self) weakSelf=self;

    request.pictureBlock=^(id result){
        
        weakSelf.verifyCodeImage =[UIImage imageWithData:result];
              [weakSelf.myTableView reloadData];
    
    };
    
    [request downLoad:URL_PICTURE_CODE];
}

-(void)netRequest{
    RegisteCell *phoneCell = [_myTableView cellForRowAtIndexPath:_indexPathPhone];
    RegisteCell *verifyCodeCell = [_myTableView cellForRowAtIndexPath:_indexPathSmsCode];
    RegisteCell *passwordCell = [_myTableView cellForRowAtIndexPath:_indexPathPassword];
    RegisteCell *repasswordCell = [_myTableView cellForRowAtIndexPath:_indexPathRepassword];

    
    
    if ([StringUtil isNullOrBlank:phoneCell.textField.text] ||
        [StringUtil isNullOrBlank:verifyCodeCell.textField.text] ||
        [StringUtil isNullOrBlank:passwordCell.textField.text] ||
        [StringUtil isNullOrBlank:repasswordCell.textField.text]) {
        
        [self createAlertView];
        self.alertView.title = @"输入内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    if (_flag==1) {
        
        [dic setObject:phoneCell.textField.text forKey:@"mobile"];
        [dic setObject:verifyCodeCell.textField.text forKey:@"mobilecode"];

    }else if (_flag==2){
         [dic setObject:phoneCell.textField.text forKey:@"email"];
        [dic setObject:verifyCodeCell.textField.text forKey:@"verify"];

    }
    
    
    [dic setObject:passwordCell.textField.text forKey:@"password"];
    [dic setObject:repasswordCell.textField.text forKey:@"repassword"];
    [dic setObject:@"on" forKey:@"read"];
    
    NSLog(@"json data is : %@" ,dic);

    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
       
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];

        }
        
    };
    
    [request netRequestWithUrl:URL_REGISTER Data:dic];
}

@end





