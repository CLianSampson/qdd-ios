//
//  HelpListVC.m
//  qdd
//
//  Created by Apple on 17/4/20.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "HelpListVC.h"
#import "HelpModel.h"
#import "HelpVC.h"

@interface HelpListVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation HelpListVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"帮助";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    
    _myTableView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
    //设置不显示多余的cell
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addLoadIndicator];
    [self netReauest];
}





-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutableArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    HelpModel *model = [_mutableArry objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HelpModel *model = [_mutableArry objectAtIndex:indexPath.row];
   
    
    HelpVC *VC = [[HelpVC alloc]init];
    VC.mainTitle = model.title;
    VC.helpId = model.helpId;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_HELP];
    
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
    
    [self netRequestGetWithUrl:urlstring Data:nil];
}


-(void)sucessDo:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"message"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有更多消息了";
        [self.alertView show];
        return;
    }
    
    
    for (NSDictionary *temp in arry) {
        
        HelpModel *model = [[HelpModel alloc]init];
        model.title = [temp objectForKey:@"title"];
        model.helpId = [temp objectForKey:@"id"];
        
        if (_mutableArry==nil) {
            _mutableArry=[[NSMutableArray alloc]init];
        }
        
        [_mutableArry addObject:model];
    }
    
    
    [self.view addSubview:_myTableView];
    [_myTableView reloadData];
    
}




@end
