//
//  MainVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "MainVC.h"
#import "AFNetRequest.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "SignCell.h"
#import "MJRefresh.h"
#import "SignModel.h"
#import "TimeUtil.h"
#import "StringUtil.h"
#import "MainRigthVC.h"
#import "SignShowVC.h"


@interface MainVC()<UITableViewDelegate,UITableViewDataSource>
{
    float buttonOrginalY;
    float buttonWidth;
    float interval;
    float fontSize;

}


@property(nonatomic,strong)UIScrollView *scrolView;

@property(nonatomic,strong)UIButton *waitForMe;
@property(nonatomic,strong)UIButton *waitForOther;
@property(nonatomic,strong)UIButton *complete;
@property(nonatomic,strong)UIButton *timeOut;

@property(nonatomic,strong)UILabel *underLabel;


@property(nonatomic,strong)UITableView *myTableView;

//1 待我签署 2 待别人签署 3已完成 4过期未签署
@property(nonatomic,assign)int status;

@property(nonatomic,strong)NSMutableArray *mutableArry;

@property(nonatomic,assign)int pageNo;

@end

@implementation MainVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
    NSLog(@"widthscale is : %f" ,WIDTH_SCALE);
   
    NSLog(@"widthscale is : %f" ,(float)1080/750/3);
}

-(void)viewDidLoad{
    _pageNo=0;
    _status=1;
    
   

    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"个人"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_rightButton];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    _label.text=@"签多多";
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont boldSystemFontOfSize:17];
    
    [self.view addSubview:_label];
    
    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 120)];
    _scrolView.backgroundColor=RGBColor(235, 239, 242);;
    [self.view addSubview:_scrolView];
    
    [self creatView];
    
}



-(void)creatView{
    if (iPhone4||iPhone5) {
        interval = 30;
    }else{
        interval = 60;
    }
    
    
    if (iPhone4||iPhone5) {
         buttonWidth = (SCREEN_WIDTH-interval*5*WIDTH_SCALE)/4;
    }else{
        buttonWidth = (SCREEN_WIDTH-interval*5*WIDTH_SCALE)/4;
    }
    
    
    
    fontSize=12;
    
    
    buttonOrginalY = _scrolView.frame.origin.y+_scrolView.frame.size.height;
    
    _waitForMe  =[[UIButton alloc]initWithFrame:CGRectMake(interval*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_waitForMe setTitle:@"待我签署" forState:UIControlStateNormal];
    _waitForMe.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [_waitForMe setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForMe addTarget:self action:@selector(waitForMeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_waitForMe];
    
    
    _waitForOther = [[UIButton alloc]initWithFrame:CGRectMake(_waitForMe.frame.origin.x+_waitForMe.frame.size.width+interval*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_waitForOther setTitle:@"待别人签署" forState:UIControlStateNormal];
    _waitForOther.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_waitForOther addTarget:self action:@selector(waitForOtherMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_waitForOther];
    
    
    _complete = [[UIButton alloc]initWithFrame:CGRectMake(_waitForOther.frame.origin.x+_waitForOther.frame.size.width+interval*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_complete setTitle:@"已完成" forState:UIControlStateNormal];
    _complete.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_complete addTarget:self action:@selector(completeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_complete];
    
    _timeOut = [[UIButton alloc]initWithFrame:CGRectMake(_complete.frame.origin.x+_complete.frame.size.width+interval*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_timeOut setTitle:@"过期未签署" forState:UIControlStateNormal];
    _timeOut.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut addTarget:self action:@selector(timeOutMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeOut];
    
//    _underLabel = [[UILabel alloc]initWithFrame:CGRectMakeCGRectMake(60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    
    _underLabel = [[UILabel alloc]initWithFrame:CGRectMake(interval*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2)];
    [_underLabel setBackgroundColor:RGBColor(0, 51, 192)];
    [self.view addSubview:_underLabel];
    
    
    UIView *background  =[[UIView alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.backgroundColor=RGBColor(200, 200, 200);
    [self.view addSubview:background];
    
    
//    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20*WIDTH_SCALE, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH-2*20*WIDTH_SCALE, SCREEN_HEIGHT-_underLabel.frame.origin.y-_underLabel.frame.size.height)];
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-_underLabel.frame.origin.y-_underLabel.frame.size.height)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor=RGBColor(200, 200, 200);

    
    [self addMjRefresh:_myTableView];
    
    [self addLoadIndicator];
    
    [self netReauest];

    
}


-(void)addMjRefresh:(UITableView *)tableView{
    float cellHeight = (44+28+46+20+29)*HEIGHT_SCALE+13+11+11 ;
    float headViewHeight = 10;
    float height = _mutableArry.count*cellHeight + headViewHeight;
    
    if (height>_myTableView.frame.size.height) {
        //上拉加载
        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            [self netReauest];
            //停止刷新
            [tableView.footer endRefreshing];
        }];

    }
    
    
}


-(void)waitForMeMethod{
    _status=1;
    _pageNo=0;
    
    _mutableArry=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(interval*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
     [_waitForMe setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];

    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];

    [_myTableView removeFromSuperview];
    [self netReauest];
    
    
}

-(void)waitForOtherMethod{
    _status=2;
    _pageNo=0;
    
     _mutableArry=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_waitForMe.frame.origin.x+_waitForMe.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    
    [_waitForOther setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_myTableView removeFromSuperview];
    [self netReauest];
}

-(void)completeMethod{
    _status=3;
    _pageNo=0;
    
     _mutableArry=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_waitForOther.frame.origin.x+_waitForOther.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    [_complete setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_myTableView removeFromSuperview];
    [self netReauest];
    
}

-(void)timeOutMethod{
    _status=4;
    _pageNo=0;
    
     _mutableArry=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_complete.frame.origin.x+_complete.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    [_timeOut setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_myTableView removeFromSuperview];
    [self netReauest];

}





#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _mutableArry.count;
}

- (SignCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SignCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
   
    
    
    switch (_status) {
        case 1:
            cell.state.text=@"待我签署";
            break;
            
        case 2:
            cell.state.text=@"待别人签署";
            break;
            
        case 3:
            cell.state.text=@"已完成";
            break;
            
        case 4:
            cell.state.text=@"过期未签署";
            break;
            
        default:
            break;
    }
    
    cell.layer.cornerRadius=3;
    cell.clipsToBounds=YES;
    
    
    SignModel *model  = (SignModel *)[_mutableArry objectAtIndex:indexPath.row];
    
    long startTimestap = [TimeUtil transStringToTimestap:model.startTime];
    long endTimestap = [TimeUtil transStringToTimestap:model.endTime];
    int intervalTime = (int)(endTimestap-startTimestap)/(24*60*60);
    
    NSString *signName = nil;
    NSString *sendPerson=nil;
    NSString *sendTime =nil;
    NSString *duration =nil;
    
    if (![StringUtil isNullOrBlank:model.title]) {
        signName = [NSString stringWithFormat:@"合同名称: %@",model.title];
    }else{
        signName = @"合同名称: ";

    }
    
    if (![StringUtil isNullOrBlank:model.phone]) {
        sendPerson = [NSString stringWithFormat:@"发送人: %@",model.phone];
    }else{
        sendPerson = @"发送人: ";
    }
    
    if (![StringUtil isNullOrBlank:model.startTime]) {
        NSString *time = [TimeUtil transDateFormate:model.startTime];
        sendTime = [NSString stringWithFormat:@"发送时间: %@",time];
    }else{
        sendTime = @"发送时间: ";
    }
    
    
    

    duration =[NSString stringWithFormat:@"签约有限期: %d天",intervalTime];
    
   
    cell.signName.text=signName;
    cell.sendPerson.text=sendPerson;
    cell.sendTime.text=sendTime;
    cell.duration.text=duration;
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SignModel *model = (SignModel *)[_mutableArry objectAtIndex:indexPath.row];
    
    SignShowVC *VC= [[SignShowVC alloc]init];
    VC.token=self.token;
    VC.authState=self.authState;
    VC.signTitle=model.title;
    VC.signId=model.signId;
    
    switch (_status) {
        case 1:
            VC.signState=WAIT_FOR_ME;
            break;
        case 2:
            VC.signState=WAIT_FOR_OTHER;
            break;
        case 3:
            VC.signState=COMPLETE;
            break;
        case 4:
            VC.signState=TIME_OUT;
            break;
            
        default:
            break;
    }
    
    VC.VC = self.sideMenuViewController.contentViewController;

    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self.sideMenuViewController setContentViewController:nav];
    [self.sideMenuViewController hideMenuViewController];
    
//    [self.navigationController pushViewController:VC animated:YES];
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return (44+28+46+20+29)*HEIGHT_SCALE+13+11+11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    header.backgroundColor=RGBColor(200, 200, 200);
    return header;
}



-(void)showLeft{
   
    [self presentLeftMenuViewController:nil];
}


-(void)showRight{
    
    MainRigthVC *vc = [[MainRigthVC alloc]init];
    vc.token=self.token;
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_SIGN];

    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSString *statusString = [NSString stringWithFormat:@"?status=%d",_status];
    NSString *pageNo =[NSString stringWithFormat:@"&p=%d",_pageNo];
    
    
    NSString *string1=[appendUrlString stringByAppendingString:statusString];
    NSString *string2=[string1 stringByAppendingString:pageNo];
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
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
    
    self.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [self netRequestGetWithUrl:string2 Data:nil];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"contract"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有更多合同了";
        [self.alertView show];
        return;
    }
    
   
    for (NSDictionary *temp in arry) {
        
        SignModel *signModel =[[SignModel alloc]init];
        signModel.signId = [temp objectForKey:@"id"];
        signModel.title = [temp objectForKey:@"title"];
        signModel.phone= [temp objectForKey:@"sendname"];

        signModel.startTime = [temp objectForKey:@"stime"];

        signModel.endTime = [temp objectForKey:@"etime"];

        
        
        if (_mutableArry==nil) {
            _mutableArry=[[NSMutableArray alloc]init];
        }
        
        [_mutableArry addObject:signModel];
        
        
    }
    
    
    [self.view addSubview:_myTableView];
    [self addMjRefresh:_myTableView];
    [_myTableView reloadData];

}

@end
