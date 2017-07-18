//
//  UserPhoneVC.m
//  qdd
//
//  Created by sampson on 2017/7/18.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "UserPhoneVC.h"
#import "AccountCell.h"
#import "ChangePhoneVC.h"

@interface UserPhoneVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation UserPhoneVC

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
    label.text=@"法人手机号";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    
    UILabel *underSeprate =[[UILabel alloc]initWithFrame:CGRectMake(0, 65+1+1+30*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    underSeprate.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underSeprate];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, underSeprate.frame.origin.y+underSeprate.frame.size.height+1, SCREEN_WIDTH, 2*107*HEIGHT_SCALE)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -tableView dataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (AccountCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"法人手机号";
        cell.rightLabel.text = _phone;
        
    }
    
    if (indexPath.row == 1) {
        cell.leftLabel.text = @"更换绑定手机号";
        cell.rightLabel.text = @">";
    }
    
    return cell;
    
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        ChangePhoneVC *VC = [[ChangePhoneVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 107*HEIGHT_SCALE;
}


@end
