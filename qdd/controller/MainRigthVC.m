//
//  MainRigthVC.m
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MainRigthVC.h"
#import "Macro.h"
#import "MessageCell.h"
#import "MessageDetailVC.h"
#import "AFNetRequest.h"
#import "MessageModel.h"
#import "MJRefresh.h"
#import "StringUtil.h"



@interface MainRigthVC()

@property(nonatomic,assign)int pageNo;

@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation MainRigthVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _pageNo=2;
    
    
//    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"消息";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];

    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    
    _myTableView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
    [self addMjRefresh:_myTableView];
    [self addLoadIndicator];
    [self netReauest];
}


-(void)addMjRefresh:(UITableView *)tableView{
    
//    float cellHeight = (48+32+26+28+50)*HEIGHT_SCALE ;
//    float headViewHeight = 0;
//    float height = _mutableArry.count*cellHeight + headViewHeight;
//    
//    //float比较大于
//    if (height - _myTableView.frame.size.height > 0.000001) {
//        //上拉加载
//        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            _pageNo++;
//            [self netReauest];
//            //停止刷新
//            [tableView.footer endRefreshing];
//        }];
//        
//    }
//    
//    //float比较等于
//    if (fabs(height - _myTableView.frame.size.height) < 0.000001 ||
//        fabs(_myTableView.frame.size.height - height) < 0.000001) {
//        
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
        _mutableArry = nil;
        
        _pageNo = 1;
        [self netReauest];
        //停止刷新
        [tableView.header endRefreshing];
    }];

    
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutableArry.count;
}


- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    MessageModel *model  = (MessageModel *)[_mutableArry objectAtIndex:indexPath.row];
   
    
    NSString *mainTitle = nil;
    NSString *subTitle=nil;
    NSString *time =nil;
    
    if ([StringUtil isNullOrBlank:model.status]) {
        cell.icon.image=[UIImage imageNamed:@"消息图标未读"];
    }else if ([model.status intValue]==0){
        cell.icon.image=[UIImage imageNamed:@"消息图标"];
    }
    
    if (![StringUtil isNullOrBlank:model.title]) {
        mainTitle = model.title;
    }else{
        mainTitle = @"";
        
    }
    
    if (![StringUtil isNullOrBlank:model.contents]) {
        subTitle = model.contents;
    }else{
        subTitle = @"";
    }
    
    if (![StringUtil isNullOrBlank:model.createTime]) {
        time = model.createTime;
    }else{
        time = @"";
    }
    

    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    MessageModel *model = (MessageModel *)[_mutableArry objectAtIndex:indexPath.row];
    
    
    MessageDetailVC *VC =[[MessageDetailVC alloc]init];
    VC.token=self.token;
    VC.messageId=model.messageId;
    
    VC.backBlock=^{
        _mutableArry=nil;
        _pageNo=0;
        [self netReauest];
    };
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (48+32+26+28+50)*HEIGHT_SCALE;
}


-(void)netReauest{
    
    if (self.token==nil) {
        return;
    }
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_MESSAGE];
    
    [urlstring appendString:self.token];
    NSString *pageNo =[NSString stringWithFormat:@"/p/%d",_pageNo];
    [urlstring appendString:pageNo];
    
    NSLog(@"string1 is : %@",urlstring );
    
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
    
    [request netRequestGetWithUrl:urlstring Data:nil];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"message"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
//        [self createAlertView];
//        self.alertView.title=@"没有更多消息了";
//        [self.alertView show];
        return;
    }
    
    
    for (NSDictionary *temp in arry) {
        
        MessageModel *model = [[MessageModel alloc]init];
        
        model.title=[temp objectForKey:@"title"];
        model.type=[temp objectForKey:@"type"];
        model.createTime=[temp objectForKey:@"ctime"];
        model.messageId=[temp objectForKey:@"id"];
        model.contents=[temp objectForKey:@"contents"];
        model.status=[temp objectForKey:@"status"];
        
        
        if (_mutableArry==nil) {
            _mutableArry=[[NSMutableArray alloc]init];
        }
        
        [_mutableArry addObject:model];
    }
    
    
    [self.view addSubview:_myTableView];
    [self addMjRefresh:_myTableView];
    [_myTableView reloadData];
    
}


@end
