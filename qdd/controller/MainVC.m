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
#import "Constants.h"


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

@property(nonatomic,strong)UIButton *haveReject;

@property(nonatomic,strong)UILabel *underLabel;


@property(nonatomic,strong)UITableView *myTableView;

//1 待我签署 2 待别人签署 3已完成 4过期未签署
@property(nonatomic,assign)int status;

@property(nonatomic,strong)NSMutableArray *mutableArry;

//@property(nonatomic,strong)NSMutableArray *waitForOtherMutableArry;
//
//@property(nonatomic,strong)NSMutableArray *waitForMeMutableArry;
//
//@property(nonatomic,strong)NSMutableArray *completeMutableArry;
//
//@property(nonatomic,strong)NSMutableArray *timeOutMutableArry;
//
//@property(nonatomic,strong)NSMutableArray *haveRejectMutableArry;



@property(nonatomic,assign)int pageNo;


@property(nonatomic,strong)UILabel *noDataLabel;//没有数据时展示

@property(nonatomic,assign)BOOL refreshFlag; //下拉刷新标志


@end

@implementation MainVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
//    [_myTableView deselectRowAtIndexPath:[_myTableView indexPathForSelectedRow] animated:YES];
    
    
    NSLog(@"widthscale is : %f" ,WIDTH_SCALE);
   
    NSLog(@"widthscale is : %f" ,(float)1080/750/3);
}

-(void)clearCellSelect{
    [_myTableView deselectRowAtIndexPath:[_myTableView indexPathForSelectedRow] animated:YES];
}

-(void)viewDidLoad{
    _pageNo=1;
    _status=1;
    
    _refreshFlag = YES; //可以下拉刷新
    
    //添加签完合同之后的通知
    [self addNotification];

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
    
    //暂时隐藏 _scrolView
//    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 120)];
    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 1)];
    _scrolView.backgroundColor=RGBColor(235, 239, 242);
    [self.view addSubview:_scrolView];
    
//    UIView *sepreate  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
//    sepreate.backgroundColor = RGBColor(235, 239, 242);
//    [self.view addSubview:sepreate];
    
    [self creatView];
}



-(void)creatView{
    if (iPhone4||iPhone5) {
        interval = 1;
        fontSize = 10;
    }else{
        interval = 10;
        fontSize=12;
    }
    
    
    if (iPhone4||iPhone5) {
         buttonWidth = (SCREEN_WIDTH-interval*5*WIDTH_SCALE)/4;
    }else{
        buttonWidth = (SCREEN_WIDTH-interval*5*WIDTH_SCALE)/4;
    }
    
    buttonWidth = (SCREEN_WIDTH - interval*WIDTH_SCALE*4)/5;
    
    
    
    
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
    
    
    _haveReject = [[UIButton alloc]initWithFrame:CGRectMake(_timeOut.frame.origin.x+_timeOut.frame.size.width+interval*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_haveReject setTitle:@"已驳回" forState:UIControlStateNormal];
    _haveReject.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [_haveReject setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_haveReject addTarget:self action:@selector(haveRefuse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_haveReject];
    
//    _underLabel = [[UILabel alloc]initWithFrame:CGRectMakeCGRectMake(60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    
    _underLabel = [[UILabel alloc]initWithFrame:CGRectMake(interval*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2)];
    [_underLabel setBackgroundColor:RGBColor(0, 51, 192)];
    [self.view addSubview:_underLabel];
    
    
    UIView *background  =[[UIView alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.backgroundColor=RGBColor(200, 200, 200);
    [self.view addSubview:background];
    
    
    //没有数据时展示
    _noDataLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height + 50, SCREEN_WIDTH, 60)];
    _noDataLabel.text = @"暂无数据";
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
    _noDataLabel.font = [UIFont systemFontOfSize:12];
    _noDataLabel.textColor = RGBColor(133, 133, 133);
    
//    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20*WIDTH_SCALE, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH-2*20*WIDTH_SCALE, SCREEN_HEIGHT-_underLabel.frame.origin.y-_underLabel.frame.size.height)];
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-_underLabel.frame.origin.y-_underLabel.frame.size.height)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor=RGBColor(200, 200, 200);
    [self.view addSubview:_myTableView];
    
    [self addMjRefresh:_myTableView];
    
    [self addLoadIndicator];
    
    if (_refreshFlag == YES) {
        [self netReauest];
        _refreshFlag = NO;
    }
    
   
}


-(void)addMjRefresh:(UITableView *)tableView{
//    float cellHeight = (44+28+46+20+29)*HEIGHT_SCALE+13+11+11 ;
//    float headViewHeight = 10;
//    float height = _mutableArry.count*cellHeight + headViewHeight;
//    
//    if (height>_myTableView.frame.size.height) {
//        //上拉加载
//        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            _pageNo++;
//            [self netReauest];
//            //停止刷新
//            [tableView.footer endRefreshing];
//        }];
//    }
    
    
    //上拉加载
    tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self netReauest];
        //停止刷新
        [tableView.footer endRefreshing];
    }];

    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //停止刷新
        [tableView.header endRefreshing];
        
        if (_refreshFlag == YES) {
             _refreshFlag = NO;
            
            _mutableArry = nil;
            //不能使用 [_mutableArry removeAllObjects] 方法，因为当下拉刷新时， _mutableArry为空，tableview会超出屏幕的范围会重新绘制，会崩
            
            _pageNo = 1;
            [self netReauest];
        }
    }];
}


-(void)waitForMeMethod{

    if (_refreshFlag == YES) {
        
        [self addLoadIndicator];
        
        _status=1;
        _pageNo=1;
        
        _mutableArry = nil;
        [_myTableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            _underLabel.frame=CGRectMake(interval*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
        }];
        
        [_waitForMe setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
        [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_haveReject setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
         [self netReauest];
        _refreshFlag = NO;
    }
   
    
    
}

-(void)waitForOtherMethod{
    
    if (_refreshFlag == YES) {
        [self addLoadIndicator];

        
        _status=2;
        _pageNo=1;
        
        _mutableArry=nil;
        [_myTableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_waitForMe.frame.origin.x+_waitForMe.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
        }];
        
        
        [_waitForOther setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
        [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_haveReject setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [self netReauest];
        _refreshFlag = NO;
    }
}

-(void)completeMethod{
    

    if (_refreshFlag == YES) {
        [self addLoadIndicator];

        
        _status=3;
        _pageNo=1;
        
        _mutableArry=nil;
        [_myTableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_waitForOther.frame.origin.x+_waitForOther.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
        }];
        
        [_complete setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
        [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_haveReject setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        

        
        [self netReauest];
        _refreshFlag = NO;
    }
}



-(void)timeOutMethod{
    
    if (_refreshFlag == YES) {
        
        [self addLoadIndicator];

        
        _status=4;
        _pageNo=1;
        
        _mutableArry=nil;
        [_myTableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_complete.frame.origin.x+_complete.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
        }];
        
        [_timeOut setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
        [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_haveReject setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        

        
        [self netReauest];
        _refreshFlag = NO;
    }

}


-(void)haveRefuse{
    
    if (_refreshFlag == YES) {
        
        [self addLoadIndicator];

        
        _status=5;
        _pageNo=1;
        
        _mutableArry=nil;
        [_myTableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            //buttonWidth-3  为了不让下划线挨到顶边
            
            _underLabel.frame=CGRectMake(interval*WIDTH_SCALE+_timeOut.frame.origin.x+_timeOut.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth-10, 2);
        }];
        
        [_haveReject setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
        
        [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        
        [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];

        
        [self netReauest];
        _refreshFlag = NO;
    }
}


#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (nil==_mutableArry || _mutableArry.count==0) {
        [self.view addSubview:_noDataLabel];
        
    }else{
        [_noDataLabel removeFromSuperview];
    }
    
    NSLog(@"_mutableArry is : %@",_mutableArry);
    NSLog(@"清空后的count is : %ld",_mutableArry.count);
    return _mutableArry.count;

}


- (SignCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SignCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
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
            
        case 5:
            cell.state.text=@"已驳回";
            
        default:
            break;
    }
    
    cell.layer.cornerRadius=3;
    cell.clipsToBounds=YES;
    
    
    NSLog(@"count is : %ld",_mutableArry.count);
    NSLog(@"section is : %ld",indexPath.section);
    
    SignModel *model  = (SignModel *)[_mutableArry objectAtIndex:indexPath.section];
    
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
    //清除cell点击效果
    [self performSelector:@selector(clearCellSelect) withObject:self afterDelay:0.5f];
    
    SignModel *model = (SignModel *)[_mutableArry objectAtIndex:indexPath.section];
    
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
        case 5:
            VC.signState = HAVE_REFUSE;
            
        default:
            break;
    }
    
    VC.VC = self.sideMenuViewController.contentViewController;
    VC.refuseSignBlock=^(){
        [self haveRefuse];
    };
    
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
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    request.context = self;
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_SIGN];
   [urlstring appendString:self.token];
    
    NSString *statusString = [NSString stringWithFormat:@"?status=%d",_status];
    NSString *pageNo =[NSString stringWithFormat:@"&p=%d",_pageNo];
    
    
    [urlstring appendString:statusString];
    [urlstring appendString:pageNo];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        /***************************************/
        _refreshFlag = YES;

        
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
        
        /***************************************/
        _refreshFlag = YES;
    };
    
    NSLog(@"获取首页合同，url is: %@",urlstring);
    [request netRequestGetWithUrl:urlstring Data:nil];
}


-(void)sucessDo:(id )result{
    
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"contract"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
//        [self createAlertView];
//        self.alertView.title=@"没有更多合同了";
//        [self.alertView show];
        
        
        
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
    
    
    [_myTableView reloadData];
}


#pragma mark 签署成功后的通知
-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitForMeMethod) name:GOTO_MAIN_CONTROLLER_FROM_SIGN_SUCESS_CONTROLLER object:nil];
}



@end





