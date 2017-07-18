//
//  SetSignaturePositionVC.m
//  qdd
//
//  Created by Apple on 17/4/21.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SetSignaturePositionVC.h"
#import "SignDetailVC.h"
#import "SignShowCell.h"
#import "SignMobileVerifyVC.h"

@interface SetSignaturePositionVC()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *mutableArry;
@property(nonatomic,strong)NSArray *pictureNameArry;
@property(nonatomic,assign)int pageNo;

@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *bottomButton;

@property(nonatomic,strong)UIImageView *personalImageView; //个人签章图片
@property(nonatomic,strong)UIImageView *enterpriseImageView; //企业签章图片

@property(nonatomic,assign)int pageNum; //第几页合同

@end

@implementation SetSignaturePositionVC


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
//    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 67, 320, 544)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    _myTableView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_myTableView];
    
    
//    _personalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_myTableView.frame.origin.x+_myTableView.frame.size.width - 90, _myTableView.frame.origin.y+_myTableView.frame.size.height - 180, 90, 90)];
      _personalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_myTableView.frame.size.width - 90, _myTableView.frame.size.height - 180, 90, 90)];
    _personalImageView.image = _personaSignaturelImage;
    [self.view addSubview:_personalImageView];
    
    
    //添加拖动手势
    [self addPanGesture];
    
    _bottomButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-98*HEIGHT_SCALE, SCREEN_WIDTH, 98*HEIGHT_SCALE)];
    _bottomButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    //    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"合同确定按钮"] forState:UIControlStateNormal];
    _bottomButton.backgroundColor = BlueRGBColor;
    [_bottomButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
       
    [self addLoadIndicator];
    [self netReauest];
}



-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)showRight{
    SignDetailVC *VC =[[SignDetailVC alloc]init];
    VC.signId=self.signId;
    VC.token=self.token;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)confirmClick{
    [self storeSignature];
}



#pragma  mark store signature
-(void)storeSignature{
    
    AFNetRequest *request =[[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_STORE_AND_DELETE_SIGNATURE];
    [urlstring appendString:self.token];
    
    NSMutableDictionary *paramasDic = [[NSMutableDictionary alloc]init];
    NSString *signStatus = [NSString stringWithFormat:@"%d",_signStatus];
    [paramasDic setObject:signStatus forKey:@"status"];  //status：合同签章类型（0，个人签署，1授权签署）
    [paramasDic setObject:_signId forKey:@"id"];
    
    
    NSMutableArray *addArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *personalSignature = [[NSMutableDictionary alloc]init];
    
    NSString *xPosition = [NSString stringWithFormat:@"%f",_personalImageView.frame.origin.x];
    NSString *yPosition = [NSString stringWithFormat:@"%f",_personalImageView.frame.origin.y];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",_pageNum];
    
    [personalSignature setObject:_personaSignaturelId forKey:@"signid"];
    [personalSignature setObject:pageNumStr forKey:@"num"];
    [personalSignature setObject:xPosition forKey:@"posX"];
    [personalSignature setObject:yPosition forKey:@"posY"];
    
//    NSMutableDictionary *enterpriseDic = [[NSMutableDictionary alloc]init];
//    [enterpriseDic setObject:@"" forKey:@"signid"];
//    [enterpriseDic setObject:@"" forKey:@"num"];
//    [enterpriseDic setObject:@"" forKey:@"posX"];
//    [enterpriseDic setObject:@"" forKey:@"posY"];
    
    [addArry addObject:personalSignature];
//    [addArry addObject:enterpriseDic];
    
    [paramasDic setObject:addArry forKey:@"add"];
    
    NSLog(@"params is : %@" ,paramasDic);
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            [weakSelf gotoMobileVerify];
            
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

    
    [request netRequestWithUrl:urlstring Data:paramasDic];
    
}





-(void)gotoMobileVerify{
    AFNetRequest *request = [[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_GET_USER_PHONE];
    
    [urlstring appendString:self.token];
    
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            //跳转到短信验证页面
            
            [weakSelf.indicator removeFromSuperview];
            
            NSDictionary *data = [result objectForKey:@"data"];
            
            NSDictionary *mobileDic =[data objectForKey:@"mobile"];
            NSString *mobile = [mobileDic objectForKey:@"mobile"];
            
            SignMobileVerifyVC *VC = [[SignMobileVerifyVC alloc]init];
            VC.token=weakSelf.token;
            VC.phoneNum=mobile;
            VC.signId  = weakSelf.signId;
            VC.signStatus = weakSelf.signStatus;
            [weakSelf.navigationController pushViewController:VC animated:YES];
            
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
    
    //    return SCREEN_HEIGHT-66-49;
    return 544;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}






-(void)netReauest{
    
    if ([StringUtil isNullOrBlank:self.token]
        || [StringUtil isNullOrBlank:self.signId]) {
        
        return;
    }
    AFNetRequest *request =[[AFNetRequest alloc]init];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SIGN_SHOW];
    
    [urlstring appendString:self.token];
    
    [urlstring appendString:@"/id/"];
    [urlstring appendString:self.signId];
    
    NSString *string = [NSString stringWithFormat:@"p/%d",_pageNo];
    [urlstring appendString:string];
    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
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
    
    request.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestGetWithUrl:urlstring Data:nil];
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


//手势处理
-(void)addPanGesture{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_personalImageView setUserInteractionEnabled:YES];//开启图片控件的用户交互
    [_personalImageView addGestureRecognizer:pan];//给图片添加手势
    
}


-(void)handlePan:(UIPanGestureRecognizer *)rec{
    
//    CGFloat KWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat KHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"class is : %@",rec.view.class);
    
    CGFloat KWidth = _myTableView.bounds.size.width;
    CGFloat KHeight = _myTableView.bounds.size.height;
    
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint point=[rec translationInView:_myTableView];
    NSLog(@"%f,%f",point.x,point.y);
    
    CGFloat centerX = rec.view.center.x+point.x;
    CGFloat centerY = rec.view.center.y+point.y;
    
    CGFloat viewHalfH = rec.view.frame.size.height/2;
    CGFloat viewhalfW = rec.view.frame.size.width/2;
    
    //确定特殊的centerY
    if (centerY - viewHalfH < _myTableView.frame.origin.y ) {
//        centerY = viewHalfH;
        centerY = 65 + viewHalfH;
    }
    if (centerY + viewHalfH > KHeight ) {
        centerY = KHeight - viewHalfH;
    }
    
    //确定特殊的centerX
    if (centerX - viewhalfW < _myTableView.frame.origin.x){
        centerX = viewhalfW;
    }
    if (centerX + viewhalfW > KWidth){
        centerX = KWidth - viewhalfW;
    }
    
    rec.view.center=CGPointMake(centerX, centerY);
    
    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    
}





#pragma mark scrollview delegate
float lastContentOffset;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"hgjahghkbknsbaba,kkghkghjann,gn,fngn,mnm");
    
    //arry 为indexpath的数组
    NSArray *arry = [_myTableView indexPathsForVisibleRows];
    if ([arry count]==1) {
        return;
    }
    
    
    if (lastContentOffset < scrollView.contentOffset.y) {
        NSIndexPath *scrollIndexPath = [arry objectAtIndex:1];
        
        [_myTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        NSArray *newArry = [_myTableView indexPathsForVisibleRows];
        
        NSIndexPath *newIndexPath = (NSIndexPath *)[newArry objectAtIndex:0];
        
        _pageNum = (int)newIndexPath.row;

    }else{
        NSLog(@"向下滚动");
        
        NSIndexPath *scrollIndexPath = [arry objectAtIndex:0];
        
       
        [_myTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        NSArray *newArry = [_myTableView indexPathsForVisibleRows];

        
        NSIndexPath *newIndexPath = (NSIndexPath *)[newArry objectAtIndex:0];
        
        _pageNum = (int)newIndexPath.row;
        
        
    }

   
}



@end








