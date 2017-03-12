//
//  MyOrder.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MyOrderVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "OrderCell.h"
#import "PayVC.h"

@interface MyOrderVC()<UITableViewDelegate,UITableViewDataSource,payMoneyProtocol>{

    UIButton *allButton;
    UIButton *unPayButton;
    UIButton *payButton;
    
    
    UITableView *tableViewGloabal;
    
    NSArray *arry;
    
}

@end

@implementation MyOrderVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    arry = @[@"1",@"2",@"3",@"4",@"5"];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"我的订单";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    
    UILabel *upperLine = [[UILabel alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH,  1)];
    upperLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upperLine];
    
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0,112, SCREEN_WIDTH,  1)];
    underLine.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underLine];
    
    
    allButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/3, 49)];
//    allButton.backgroundColor=[UIColor redColor];
    [allButton addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
    allButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [allButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    
    
    unPayButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    unPayButton.backgroundColor=[UIColor yellowColor];
    [unPayButton addTarget:self action:@selector(unPay) forControlEvents:UIControlEventTouchUpInside];
    [unPayButton setTitle:@"未支付" forState:UIControlStateNormal];
     unPayButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    

    
    payButton = [[UIButton alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    payButton.backgroundColor=[UIColor greenColor];
    [payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [payButton setTitle:@"已支付" forState:UIControlStateNormal];
     payButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [payButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    

    
    [self.view addSubview:allButton];
    [self.view addSubview:unPayButton];
    [self.view addSubview:payButton];
    
    _underLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2)];
    _underLabel.backgroundColor=RGBColor(0 , 51, 102);
    [self.view addSubview:_underLabel];
    
    UILabel *sepreteAll = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 64+49/4, 1, 49/2)];
    sepreteAll.backgroundColor=SepreateRGBColor;
    
    
    UILabel *sepretePay = [[UILabel alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3, 64+49/4, 1, 49/2)];
    sepretePay.backgroundColor=SepreateRGBColor;
    
    [self.view addSubview:sepreteAll];
    [self.view addSubview:sepretePay];
    
    [self createTableView];
}




-(void)createTableView{
    
    tableViewGloabal = [[UITableView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
    tableViewGloabal.delegate=self;
    tableViewGloabal.dataSource=self;
    
    tableViewGloabal.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableViewGloabal];
}



-(void)all{
    [UIView animateWithDuration:0.5 animations:^{
        [allButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [payButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];

        
        _underLabel.frame=CGRectMake(0+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);
    }];
}


-(void)unPay{
    [UIView animateWithDuration:0.5 animations:^{
        
        [unPayButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [allButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [payButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        _underLabel.frame= CGRectMake(SCREEN_WIDTH/3+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);

    }];
    
   }


-(void)pay{
    [UIView animateWithDuration:0.5 animations:^{
        
        [payButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [allButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        _underLabel.frame=  CGRectMake(2*SCREEN_WIDTH/3+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);
        
    }];

    
   
}

-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}




#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (OrderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
        if (indexPath.row%2==0) {
            
        }else{
            [cell.pay removeFromSuperview];
        }
        
    }
    
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    OrderCell *cell = (OrderCell*) [tableView cellForRowAtIndexPath:indexPath];
    cell.delegate=self;
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",(48+32+26+28+50)*HEIGHT_SCALE);
    NSLog(@"%f",HEIGHT_SCALE);
    
    if ( indexPath.row%2==0) {
        return (30+45+38+30+32+32+32+32+107)*HEIGHT_SCALE+13+12+12+12+12;
    }else{
        return (30+45+38+30+32+32+32+32)*HEIGHT_SCALE+13+12+12+12+12;
    }
    
   
    
    
}


#pragma mark -OrderCell delegate
-(void)payMoney{
    PayVC *VC = [[PayVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
