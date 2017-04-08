//
//  SignShowVC.m
//  qdd
//
//  Created by Apple on 17/4/2.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignShowVC.h"
#import "SignDetailVC.h"
#import "SignShowCell.h"

@interface SignShowVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)NSArray *pictureNameArry;
@property(nonatomic,assign)int pageNo;

@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *bottomButton;

@end

@implementation SignShowVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    _pageNo=0;
    
    [super viewDidLoad];
    
    [self createNavition];
    
    self.mytitle.text=_signTitle;
    
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:_rightButton];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"详情按钮"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self creteView];
    
    
    
}



-(void)creteView{
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];

    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, SCREEN_HEIGHT-67)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
     _myTableView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_myTableView];
    
    [self createBottomButton];
    
    switch (_signState) {
        case 1:
            [_bottomButton setTitle:@"确定" forState:UIControlStateNormal];
            break;
        case 2:
            [_bottomButton setTitle:@"确定" forState:UIControlStateNormal];
            break;
        case 3:
            [_bottomButton removeFromSuperview];
            break;
        case 4:
            [_bottomButton removeFromSuperview];
            break;
            
        default:
            break;
    }

    
    [self addLoadIndicator];
    [self netReauest];
}



-(void)createBottomButton{
    _bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, SCREEN_HEIGHT-81*HEIGHT_SCALE-3, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    _bottomButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"合同确定按钮"] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(signSign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
}


-(void)signSign{
}


#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _pictureNameArry.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (SignShowCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SignShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SignShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    NSString *path = (NSString*)[_pictureNameArry objectAtIndex:indexPath.row];

    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_COMMON];

    NSString *appendUrlString=[urlstring stringByAppendingString:path];

    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    request.pictureBlock=^(id result){
        cell.imageShow.image=[UIImage imageWithData:result];
    };
    
    request.pictureFailedBlock=^{
//        [self.indicator removeFromSuperview];
//        
//        [self createAlertView];
//        self.alertView.title=@"网络有点问题哦，无法下载合同";
//        [self.alertView show];
    };
    
    [request downLoadPicture:appendUrlString];
    
    
    
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_HEIGHT-66-49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}








-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
}


-(void)showRight{
    SignDetailVC *VC =[[SignDetailVC alloc]init];
    VC.signId=self.signId;
    VC.token=self.token;
    [self.navigationController pushViewController:VC animated:YES];
}




-(void)netReauest{
    
    if ([StringUtil isNullOrBlank:self.token]
        || [StringUtil isNullOrBlank:self.signId]) {
        
        return;
    }
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SIGN_SHOW];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSString *string1 = [appendUrlString stringByAppendingString:@"/id/"];
    NSString *string2 = [string1 stringByAppendingString:self.signId];
    
    NSString *string3 = [NSString stringWithFormat:@"p/%d",_pageNo];
    NSString *string4 = [string2 stringByAppendingString:string3];
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
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
    
    self.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [self netRequestGetWithUrl:string4 Data:nil];
}


-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    
    _pictureNameArry = [data objectForKey:@"pic_name"];
    
    if (_pictureNameArry==nil
        || (NSNull *)_pictureNameArry==[NSNull null]
        || [_pictureNameArry count]==0){
        return;
    }
    
    
    
    [_myTableView reloadData];
    
}




@end
