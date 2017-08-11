//
//  SetVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SetVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "AboutVC.h"
#import "SecurityVC.h"
#import "UserAccountVC.h"
#import "Constants.h"
#import "LoginVC.h"
#import "SaveToMemory.h"

@interface SetVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIButton *logoutButton;

@end

@implementation SetVC



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"设置";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self creteView];
    
    [self addNotification];
}



-(void)creteView{
    UIView *background  =[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    background.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:background];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 64+30*HEIGHT_SCALE, SCREEN_WIDTH, 30*HEIGHT_SCALE)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+30*HEIGHT_SCALE, SCREEN_WIDTH, 107*3*HEIGHT_SCALE)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    
    _myTableView.scrollEnabled=NO;
    
    [self.view addSubview:_myTableView];
    
    
    _logoutButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, _myTableView.frame.origin.y+_myTableView.frame.size.height+140*HEIGHT_SCALE, 300, 41)];
    [_logoutButton setBackgroundImage:[UIImage imageNamed:@"退出登陆"] forState:UIControlStateNormal];
    [_logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_logoutButton];
}




#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"账户资料";
            break;
            
        case 1:
            cell.textLabel.text=@"安全设置";
            break;
            
        case 2:
            cell.textLabel.text=@"关于签多多";
            break;
            
        default:
            break;
    }
    
   
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        UserAccountVC *VC = [[UserAccountVC alloc]init];
        VC.token=self.token;
        VC.accountFlag=self.accountFlag;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==1){
        SecurityVC *VC = [[SecurityVC alloc]init];
        VC.token=self.token;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==2){
        AboutVC *VC  =[[AboutVC alloc]init];
        VC.token=self.token;
        [self.navigationController pushViewController:VC animated:YES];

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 107*HEIGHT_SCALE;
}







-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
//    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
}



#pragma mark 认证成功后的通知
-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeft) name:GOTO_MAIN_CONTROLLER_FROM_BIND_MAIL_SUCESS_CONTROLLER object:nil];
    
    //个人认证成功后更改认证状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVerifyState) name:CHANGE_VERIFY_STATE_AFTER_USER_VERIFY object:nil];
}

-(void)changeVerifyState{
    self.verifyState = HAVE_VERIFY;
    
    //重新存储
    [self saveToMemory];
    
}





@end
