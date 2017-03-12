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

@interface UserAccountVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

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
    
    
    if (indexPath.section==1) {
        cell.leftLabel.text=@"绑定邮箱";
        cell.rightLabel.text=@"未绑定 >";
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.leftLabel.text=@"名称";
            cell.rightLabel.text=@"林林集";
            break;
            
        case 1:
            cell.leftLabel.text=@"账号";
            cell.rightLabel.text=@"18771098004";
            
            break;
            
        case 2:
            cell.leftLabel.text=@"身份证";
            cell.rightLabel.text=@"67777878778787878778";
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        BindingMailVC *VC =[[BindingMailVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    return;
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
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    header.backgroundColor=RGBColor(241, 241, 241);
    
    
    UILabel *upperSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    upperSeprate.backgroundColor=SepreateRGBColor;
    [header addSubview:upperSeprate];
    
    UILabel *underSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 9, SCREEN_WIDTH, 1)];
    underSeprate.backgroundColor=SepreateRGBColor;
    [header addSubview:underSeprate];
    
    return header;
}




-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
