//
//  UserAccountVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "UserAccountVC.h"
#import "Macro.h"
#import "AccountCell.h"
#import "BindingMailVC.h"
#import "AFNetRequest.h"
#import "UserPhoneVC.h"

@interface UserAccountVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *idNum;
@property(nonatomic,strong)NSString *checkStatus;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *mail;
@property(nonatomic,strong)NSString *phone;

@end

@implementation UserAccountVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"账户资料";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
//    UILabel *upperSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH, 65+1, 1)];
//    upperSeprate.backgroundColor=SepreateRGBColor;
//    [self.view addSubview:upperSeprate];
    
    UILabel *underSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 65+1+1+30*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    underSeprate.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underSeprate];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, underSeprate.frame.origin.y+underSeprate.frame.size.height+1, SCREEN_WIDTH, 107*4*HEIGHT_SCALE+26*HEIGHT_SCALE)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [self netReauest];
    
}




#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (AccountCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if (self.accountFlag==USER_ACCOUNT) {
        if (indexPath.section==1) {
            if ([StringUtil isNullOrBlank:_mail]) {
                cell.leftLabel.text=@"绑定邮箱";
                cell.rightLabel.text=@"未绑定 >";
               
            }else{
                cell.leftLabel.text=@"邮箱";
                
                NSMutableString *mustableString = [NSMutableString stringWithString:_mail];
                [mustableString appendString:@" >"];
                
                cell.rightLabel.text=mustableString;
                
            }
            
            return cell;
        }
        
        
        switch (indexPath.row) {
            case 0:
                cell.leftLabel.text=@"名称";
                cell.rightLabel.text=_name;
                break;
                
            case 1:
                cell.leftLabel.text=@"账号";
                cell.rightLabel.text=_account;
                
                break;
                
            case 2:
                cell.leftLabel.text=@"身份证";
                cell.rightLabel.text=_idNum;
                
                break;
                
            default:
                break;
        }
        
        
        return cell;
    }else{
        if (indexPath.section==1) {
            if ([StringUtil isNullOrBlank:_phone]) {
                cell.leftLabel.text=@"法人手机号";
                cell.rightLabel.text=@"未绑定 >";
            }else{
                cell.leftLabel.text=@"法人手机号";
                
                NSMutableString *mustableString = [NSMutableString stringWithString:_phone];
                [mustableString appendString:@" >"];
                
                cell.rightLabel.text=mustableString;
                
            }
            
            return cell;
        }
        
        
        switch (indexPath.row) {
            case 0:
                cell.leftLabel.text=@"企业名称";
                cell.rightLabel.text=_name;
                break;
                
            case 1:
                cell.leftLabel.text=@"账号";
                cell.rightLabel.text=_account;
                
                break;
                
            case 2:
                cell.leftLabel.text=@"法人身份证号";
                cell.rightLabel.text=_idNum;
                
                break;
                
            default:
                break;
        }
        
        
        return cell;
    }
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    
    
    if (self.accountFlag == USER_ACCOUNT) {
        BindingMailVC *VC =[[BindingMailVC alloc]init
                            ];
        VC.token=self.token;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        UserPhoneVC *VC = [[UserPhoneVC alloc]init];
        VC.token = self.token;
        VC.phone = _phone;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 107*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    
    return 26*HEIGHT_SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 26*HEIGHT_SCALE)];
    header.backgroundColor=RGBColor(241, 241, 241);
    
    
    UILabel *upperSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    upperSeprate.backgroundColor=SepreateRGBColor;
    [header addSubview:upperSeprate];
    
    UILabel *underSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 26*HEIGHT_SCALE-1, SCREEN_WIDTH, 1)];
    underSeprate.backgroundColor=SepreateRGBColor;
    [header addSubview:underSeprate];
    
    return header;
}




-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)netReauest{
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_GET_ACCOUNT_INFO];
    
    [urlstring appendString:self.token];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf doSucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
    };
    
    NSLog(@"获取个人信息: %@",urlstring);
    [request netRequestGetWithUrl:urlstring Data:nil];
}


-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    _idNum =[data objectForKey:@"sfz"];
     _checkStatus =[data objectForKey:@"cherk"];
     _name =[data objectForKey:@"name"];
     _account =[data objectForKey:@"idname"];
     _mail =[data objectForKey:@"mail"];
     _phone =[data objectForKey:@"tel"];
    
    [_tableView reloadData];
    
}




@end
