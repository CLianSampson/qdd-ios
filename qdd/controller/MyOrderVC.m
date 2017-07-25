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
#import "OrderModel.h"

@interface MyOrderVC()<UITableViewDelegate,UITableViewDataSource,payMoneyProtocol>{

    UIButton *allButton;
    UIButton *unPayButton;
    UIButton *payButton;
    
}

@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,assign)int orstatus;  //订单状态 未完成0 已完成1 全部 2
@property(nonatomic,assign)int pageNo;

@property(nonatomic,assign)int price;
@property(nonatomic,strong)NSString *orderId;


@end

@implementation MyOrderVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
   
    
    _pageNo=1;
    _orstatus=2;
    
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
    [allButton addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
    allButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [allButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
    
    
    unPayButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    unPayButton.backgroundColor=[UIColor yellowColor];
    [unPayButton addTarget:self action:@selector(unPayClick) forControlEvents:UIControlEventTouchUpInside];
    [unPayButton setTitle:@"未支付" forState:UIControlStateNormal];
     unPayButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    

    
    payButton = [[UIButton alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3, 64, SCREEN_WIDTH/3, 49)];
//    payButton.backgroundColor=[UIColor greenColor];
    [payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
    [self addMjRefresh:_myTableView];
    
    [self addLoadIndicator];
    
    [self netReauest];

}

-(void)addMjRefresh:(UITableView *)tableView{
    
    //上拉加载
    tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _pageNo++;
        [self netReauest];
        //停止刷新
        [tableView.footer endRefreshing];
    }];
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _mutableArry = nil;
        
        _pageNo = 1;
        [self netReauest];
        //停止刷新
        [tableView.header endRefreshing];
    }];
}


-(void)allClick{
    [UIView animateWithDuration:0.5 animations:^{
        [allButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [payButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        
        _underLabel.frame=CGRectMake(0+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);
    }];
    
    _mutableArry=nil;
    [_myTableView reloadData];
    _pageNo=1;
    _orstatus=2;
    [self netReauest];
}


-(void)unPayClick{
    [UIView animateWithDuration:0.5 animations:^{
        
        [unPayButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [allButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [payButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        _underLabel.frame= CGRectMake(SCREEN_WIDTH/3+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);
        
    }];

    
    _mutableArry=nil;
    [_myTableView reloadData];
    _pageNo=1;
     _orstatus=0;
    [self netReauest];
    
}


-(void)payClick{
    [UIView animateWithDuration:0.5 animations:^{
        
        [payButton setTitleColor:RGBColor(0, 51, 102) forState:UIControlStateNormal];
        
        [allButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [unPayButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        _underLabel.frame=  CGRectMake(2*SCREEN_WIDTH/3+SCREEN_WIDTH/12, 113-2, SCREEN_WIDTH/3/2, 2);
        
    }];

    
    _mutableArry = nil;
    [_myTableView reloadData];
    _pageNo=1;
    _orstatus=1;
    [self netReauest];
}

-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}




#pragma mark -tableView dataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutableArry.count;
}


- (OrderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //不使用重用功能
//    static NSString *cellIdentifier = @"Cell";
    
//    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    OrderCell *cell;
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        
        OrderModel *model = (OrderModel *)[_mutableArry objectAtIndex:indexPath.row];
        
        NSString *type = nil;
        NSString *price = nil;
        NSString *number = nil;
        NSString *orderId = nil;
        NSString *createTime = nil;
        //返回参数无
        long startTimestap = [TimeUtil transStringToTimestap:model.creatTime];
        long endTimestap = [TimeUtil transStringToTimestap:model.endTime];
        int intervalTime = (int)(endTimestap-startTimestap)/(24*60*60);
        
        NSString *duration = [NSString stringWithFormat:@"签约有效期: %d天",intervalTime];
        
        if (![StringUtil isNullOrBlank:model.name]) {
            type = [NSString stringWithFormat:@"套餐类型:   %@",model.name];
        }else{
             type = [NSString stringWithFormat:@"套餐类型:"];
        }
        
        
        if (![StringUtil isNullOrBlank:model.price]) {
            price = [NSString stringWithFormat:@"价格: %@元",model.price];
        }else{
            price = [NSString stringWithFormat:@"价格:"];
        }
        
        if (![StringUtil isNullOrBlank:model.number]) {
            number = [NSString stringWithFormat:@"可使用次数: %@次",model.number];
        }else{
            number = [NSString stringWithFormat:@"可使用次数:"];
        }
        
        if (![StringUtil isNullOrBlank:model.orderId]) {
            orderId = [NSString stringWithFormat:@"订单编号: %@",model.orderId];
        }else{
            orderId = [NSString stringWithFormat:@"订单编号:"];
        }

        if (![StringUtil isNullOrBlank:model.creatTime]) {
            createTime = [NSString stringWithFormat:@"下单时间: %@",model.creatTime];
        }else{
            createTime = [NSString stringWithFormat:@"下单时间:"];
        }
        
        
        
        cell.type.text=type;
        cell.price.text=price;
        cell.useTimes.text=number;
        cell.signDuration.text=duration;
        cell.orderId.text=orderId;
        cell.orderTime.text=createTime;
        
        if ([model.status intValue]==0) {
            
            
            [cell addSubview:cell.pay];
        }else if ([model.status intValue]==1) {
           

        }
        
        NSLog(@"status : %d",[model.status intValue]);

    }
    
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *model = (OrderModel *)_mutableArry[indexPath.row];
    _price = (int)([model.price floatValue]*100);
    _orderId = model.orderId;
    
    OrderCell *cell = (OrderCell*) [tableView cellForRowAtIndexPath:indexPath];
    cell.delegate=self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OrderModel *model = (OrderModel *)[_mutableArry objectAtIndex:indexPath.row];
    
    if ( [model.status intValue]==0) {
        return (30+45+38+30+32+32+32+32+107)*HEIGHT_SCALE+13+12+12+12+12;
    }else if([model.status intValue]==1){
        return (30+45+38+30+32+32+32+32)*HEIGHT_SCALE+13+12+12+12+12;
    }else{
        return 0;
    }
}


#pragma mark -OrderCell delegate
-(void)payMoney{
    PayVC *VC = [[PayVC alloc]init];
    VC.price = _price;
    VC.orderId = _orderId;
    VC.token = self.token;
    [self.navigationController pushViewController:VC animated:YES];
}




-(void)netReauest{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    request.context = self;

    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_ORDER];
    
    [urlstring appendString:self.token];
    
    NSString *pageNo =[NSString stringWithFormat:@"/p/%d",_pageNo];
    
    [urlstring appendString:pageNo];
    
    NSDictionary *dic = @{@"orstatus":[NSString stringWithFormat:@"%d",_orstatus]};
    
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
    
    NSLog(@"获取订单的url is : %@",urlstring);
    NSLog(@"获取订单的参数 is : %@",dic);
    [request netRequestWithUrl:urlstring Data:dic];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"orlist"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有更多订单了";
        [self.alertView show];
        return;
    }
    
    
    for (NSDictionary *temp in arry) {
        
        OrderModel *model =[[OrderModel alloc]init];
        model.systemId = [temp objectForKey:@"id"];
        model.orderId = [temp objectForKey:@"orderid"];
        model.status= [temp objectForKey:@"status"];
        
        model.creatTime = [temp objectForKey:@"ctime"];
        model.endTime = [temp objectForKey:@"etime"];
        
        model.name = [temp objectForKey:@"name"];
        model.number = [temp objectForKey:@"num"];
        model.price = [temp objectForKey:@"price"];
        
        if (_mutableArry==nil) {
            _mutableArry=[[NSMutableArray alloc]init];
        }
        
        [_mutableArry addObject:model];
    }
    
    
    [_myTableView reloadData];
    
}

@end




