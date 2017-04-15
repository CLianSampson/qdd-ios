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
#import "ChoosePersonalSignVC.h"
#import "ChooseEnterpriseSignatureVC.h"

@interface SignShowVC()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)NSArray *pictureNameArry;
@property(nonatomic,assign)int pageNo;

@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *bottomButton;

@property(nonatomic,strong)UIButton *leftBottomButton;
@property(nonatomic,strong)UIButton *rightBottomButton;

@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *personalSignButton;
@property(nonatomic,strong)UIButton *enterpriseSignButton;
@property(nonatomic,strong)UIView *sepreateLine;

@property(nonatomic,strong)UIView *alphaView;

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
//    _bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, SCREEN_HEIGHT-81*HEIGHT_SCALE-3, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
//    _bottomButton.titleLabel.font=[UIFont systemFontOfSize:14];
//    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"合同确定按钮"] forState:UIControlStateNormal];
//    [_bottomButton addTarget:self action:@selector(signSign) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_bottomButton];
    
     _leftBottomButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-81*HEIGHT_SCALE-3, SCREEN_WIDTH/2-0.5, 81*HEIGHT_SCALE)];
    _leftBottomButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_leftBottomButton setTitle:@"驳回" forState:UIControlStateNormal];
    [_leftBottomButton setBackgroundImage:[UIImage imageNamed:@"合同确定按钮"] forState:UIControlStateNormal];
    [_leftBottomButton addTarget:self action:@selector(refuseSign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftBottomButton];
    
    _rightBottomButton  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, SCREEN_HEIGHT-81*HEIGHT_SCALE-3, SCREEN_WIDTH/2-0.5, 81*HEIGHT_SCALE)];
    _rightBottomButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_rightBottomButton setTitle:@"签署" forState:UIControlStateNormal];
    [_rightBottomButton setBackgroundImage:[UIImage imageNamed:@"合同确定按钮"] forState:UIControlStateNormal];
    [_rightBottomButton addTarget:self action:@selector(signSign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBottomButton];
    
}

-(void)refuseSign{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"是否驳回" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    alertView.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-30, 100, 60);
    alertView.delegate=self;
    [alertView show];
}


-(void)signSign{
    [_rightBottomButton removeFromSuperview];
    [_leftBottomButton removeFromSuperview];
    
    _alphaView = [[UIView alloc]initWithFrame:self.view.frame];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.16;
    [self.view addSubview:_alphaView];
    
    
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(23*WIDTH_SCALE, SCREEN_HEIGHT-(9+114)*HEIGHT_SCALE, SCREEN_WIDTH-46*WIDTH_SCALE, 114*HEIGHT_SCALE)];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _cancelButton.backgroundColor=[UIColor whiteColor];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.layer.cornerRadius=6;
    [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    if (self.authState == NOT_AUTH) {
        _personalSignButton = [[UIButton alloc]initWithFrame:CGRectMake(23*WIDTH_SCALE, _cancelButton.frame.origin.y-20*HEIGHT_SCALE-114*HEIGHT_SCALE, SCREEN_WIDTH-46*WIDTH_SCALE, 114*HEIGHT_SCALE)];
        [_personalSignButton setTitle:@"个人签署" forState:UIControlStateNormal];
        _personalSignButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _personalSignButton.backgroundColor=[UIColor whiteColor];
        [_personalSignButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _personalSignButton.layer.cornerRadius=6;
        [_personalSignButton addTarget:self action:@selector(personalSign) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_personalSignButton];
    }else{
        _enterpriseSignButton = [[UIButton alloc]initWithFrame:CGRectMake(23*WIDTH_SCALE, _cancelButton.frame.origin.y-20*HEIGHT_SCALE-114*HEIGHT_SCALE, SCREEN_WIDTH-46*WIDTH_SCALE, 114*HEIGHT_SCALE)];
        [_enterpriseSignButton setTitle:@"代表企业签署" forState:UIControlStateNormal];
        _enterpriseSignButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _enterpriseSignButton.backgroundColor = [UIColor whiteColor];
        [_enterpriseSignButton setTitleColor:RGBColor(25, 136, 246) forState:UIControlStateNormal];
        [_enterpriseSignButton addTarget:self action:@selector(enterpriseSign) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_enterpriseSignButton];
        
        //设置下面圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_enterpriseSignButton.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight    cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _enterpriseSignButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _enterpriseSignButton.layer.mask = maskLayer;
        
        
        _sepreateLine = [[UIView alloc]initWithFrame:CGRectMake(23*WIDTH_SCALE, _enterpriseSignButton.frame.origin.y-1, SCREEN_WIDTH-46*WIDTH_SCALE, 1)];
        _sepreateLine.backgroundColor=RGBColor(214, 214, 214);
        [self.view addSubview:_sepreateLine];
        
        
        _personalSignButton = [[UIButton alloc]initWithFrame:CGRectMake(23*WIDTH_SCALE, _sepreateLine.frame.origin.y-114*HEIGHT_SCALE, SCREEN_WIDTH-46*WIDTH_SCALE, 114*HEIGHT_SCALE)];
        [_personalSignButton setTitle:@"个人签署" forState:UIControlStateNormal];
        _personalSignButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _personalSignButton.backgroundColor = [UIColor whiteColor];
        [_personalSignButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_personalSignButton addTarget:self action:@selector(personalSign) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_personalSignButton];
        
        //设置上面圆角
        UIBezierPath *maskPathUp = [UIBezierPath bezierPathWithRoundedRect:_personalSignButton.bounds      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight    cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayerUp = [[CAShapeLayer alloc] init];
        maskLayerUp.frame = _personalSignButton.bounds;
        maskLayerUp.path = maskPathUp.CGPath;
        _personalSignButton.layer.mask = maskLayerUp;

    }
    
}


-(void)cancel{
    [_alphaView removeFromSuperview];
    [_cancelButton removeFromSuperview];
    
    [_personalSignButton removeFromSuperview];
    [_enterpriseSignButton removeFromSuperview];
    [_sepreateLine removeFromSuperview];
    
    [self.view addSubview:_leftBottomButton];
    [self.view addSubview:_rightBottomButton];
}

-(void)personalSign{
    ChoosePersonalSignVC *VC = [[ChoosePersonalSignVC alloc]init];
    VC.token = self.token;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)enterpriseSign{
    ChooseEnterpriseSignatureVC *VC = [[ChooseEnterpriseSignatureVC alloc]init];
    VC.token = self.token;
    [self.navigationController pushViewController:VC animated:YES];
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

#pragma mark UIAlertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self refuseSignNet];
    }
}

#pragma mark 驳回合同
-(void)refuseSignNet{
    if ([StringUtil isNullOrBlank:self.token]
        || [StringUtil isNullOrBlank:self.signId]) {
        
        return;
    }
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_REFUSE_SIGN];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSString *string1 = [appendUrlString stringByAppendingString:@"/id/"];
    NSString *string2 = [string1 stringByAppendingString:self.signId];
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];

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



@end




