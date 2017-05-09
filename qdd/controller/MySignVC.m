//
//  MySignVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MySignVC.h"
#import "RESideMenu.h"
#import "SignatureCell.h"
#import "SignatureModel.h"
#import "AddSignatureVC.h"

@interface MySignVC()<UITableViewDelegate,UITableViewDataSource,DeleteSignatureDelegate>


@property(nonatomic,strong)NSMutableArray *mutableArry;

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)SignatureModel *enterpriseSignatureModel; //企业签章，只有一个

@end

@implementation MySignVC


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
    label.text=@"我的签名";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-100, 31, 100, 22)];
    [self.view addSubview:addButton];
    [addButton setTitle:@"添加签章" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    addButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [addButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UILabel *backGround = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    backGround.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backGround];
    
    
    
    UILabel *under = [[UILabel alloc]initWithFrame:CGRectMake(0, backGround.frame.origin.y+backGround.frame.size.height+1, SCREEN_WIDTH, 1)];
    under.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:under];
    
    
    _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, under.frame.origin.y+1, SCREEN_WIDTH, SCREEN_HEIGHT-under.frame.origin.y) style:UITableViewStylePlain];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    [self addLoadIndicator];
    [self netReauest];
    
}


-(void)complete{
    AddSignatureVC *VC = [[AddSignatureVC alloc]init];
    VC.token = self.token;
    VC.backBlock=^{
        _mutableArry=nil;
        [self netReauest];
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}




#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return _mutableArry.count;
    }else{
        if (_enterpriseSignatureModel==nil) {
            return 0;
        }else{
            return 1;
        }
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (SignatureCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *cellIdentifier = @"Cell";
    
    
    if (indexPath.section==0) {
        
        SignatureCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        if (cell == nil) {
            cell = [[SignatureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        
        
        SignatureModel *model = (SignatureModel*)[_mutableArry objectAtIndex:indexPath.row];
        
        NSMutableString  *urlstring=[NSMutableString stringWithString:@"https://www.qiandd.com"];
        
        NSString *appendUrlString=[urlstring stringByAppendingString:model.path];
        
        
        
        //为同一个block
        //    self.pictureBlock=^(id result){
        //        cell.signImageView.image=[UIImage imageWithData:result];
        //
        //    };
        //    [self downLoad:appendUrlString];
        AFNetRequest *request = [[AFNetRequest alloc]init];
        request.pictureBlock=^(id result){
            cell.signImageView.image=[UIImage imageWithData:result];
            
            //默认选择第一个签章
            if (indexPath.row != 0) {
                
                [cell.signImageView addSubview:cell.signImageView.deleteButton];
                
            }
            
            cell.signImageView.deleteSignatureDelegate = self;
        };
        [request downLoadPicture:appendUrlString];
        
        return cell;
        
    }
    
    
    
    static NSString *enterpriseCellIdentifier = @"enterpriseCell";
    //企业签章
    SignatureCell *cell = [tableView dequeueReusableCellWithIdentifier:enterpriseCellIdentifier];
    if (cell == nil) {
        cell = [[SignatureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:enterpriseCellIdentifier];
    }
    
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:@"https://www.qiandd.com"];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:_enterpriseSignatureModel.path];
    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    request.pictureBlock=^(id result){
        cell.signImageView.image=[UIImage imageWithData:result];
    };
    [request downLoadPicture:appendUrlString];
    
    
    [cell.signImageView.chooseImage removeFromSuperview];
    [cell.signImageView.unChooseImage removeFromSuperview];
    
    
    [cell.signImageView.deleteButton removeFromSuperview];
    
    return cell;
    
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        SignatureCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.signImageView addSubview:cell.signImageView.chooseImage];
        
        SignatureModel *model = [_mutableArry objectAtIndex:indexPath.row];
        
        [self setDefaultSign:model.signatureId];
    }
    
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (285+33)*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 28*2*HEIGHT_SCALE+16;
    }else{
        return 28*4*HEIGHT_SCALE+16;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 28*2*HEIGHT_SCALE+16)];
        header.backgroundColor=[UIColor whiteColor];
        
        //按17号字体算
        UILabel *personSign = [[UILabel alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, 28*HEIGHT_SCALE, SCREEN_WIDTH-42*WIDTH_SCALE, 16)];
        
        personSign.text=@"个人签章";
        personSign.font=[UIFont boldSystemFontOfSize:16];
        [header addSubview:personSign];
        
        return header;
    }
    
    
    UIView *enterpriseHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 28*4*HEIGHT_SCALE+16)];
    
    //按17号字体算
    UILabel *enterpriseSign = [[UILabel alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, 28*3*HEIGHT_SCALE, SCREEN_WIDTH-42*WIDTH_SCALE, 16)];
    
    enterpriseSign.text=@"企业签章";
    enterpriseSign.font=[UIFont boldSystemFontOfSize:16];
    [enterpriseHeader addSubview:enterpriseSign];
    
    return enterpriseHeader;
    
    
}



-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}


-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_SIGNATURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    __weak typeof(self) weakSelf=self;
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
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
    
    [request netRequestGetWithUrl:appendUrlString Data:nil];
}


-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"allsign"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有个人签章";
        [self.alertView show];
    }else{
        for (NSDictionary *temp in arry) {
            
            SignatureModel *model =[[SignatureModel alloc]init];
            model.signatureId = [temp objectForKey:@"id"];
            model.name = [temp objectForKey:@"name"];
            model.path= [temp objectForKey:@"path"];
            
            model.uid = [temp objectForKey:@"uid"];
            
            model.status = [temp objectForKey:@"status"];
            model.ctime = [temp objectForKey:@"ctime"];
            model.utime = [temp objectForKey:@"utime"];
            
            if (_mutableArry==nil) {
                _mutableArry=[[NSMutableArray alloc]init];
            }
            
            [_mutableArry addObject:model];
        }
    }
    
    
    
    
    
    //企业签章
    NSDictionary *dic = [data objectForKey:@"csign"];
    if (dic==nil
        || [dic isEqual:[NSNull null]]) {
        
        [self createAlertView];
        self.alertView.title=@"没有企业签章";
        [self.alertView show];
        
    }else{
        _enterpriseSignatureModel = [[SignatureModel alloc]init];
        _enterpriseSignatureModel.signatureId = [dic objectForKey:@"id"];
        _enterpriseSignatureModel.path= [dic objectForKey:@"path"];
        _enterpriseSignatureModel.uid = [dic objectForKey:@"uid"];
    }
    
    
    
    [_myTableView reloadData];
    
}


//设置默认签章
-(void)setDefaultSign:(NSString *)signId{
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SET_DETAULT_SIGNATURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSString *string1 = [appendUrlString stringByAppendingString:@"/sid/"];
    NSString *string2 = [string1 stringByAppendingString:signId];
    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];

    
    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
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
    
    [request netRequestGetWithUrl:string2 Data:nil];
}


#pragma mark deleteSignatureDelegate
-(void)deleteSignature:(UIButton *)sender{
    NSLog(@"delete button click sucess");
    
    //获取model
    SignatureCell *cell = (SignatureCell *)[sender superview];
    
    NSIndexPath * indexPath = [_myTableView indexPathForCell:cell];
    
    SignatureModel *model = (SignatureModel*)[_mutableArry objectAtIndex:indexPath.row];
    
    
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_DELETE_SLGNATURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSString *string1 = [appendUrlString stringByAppendingString:@"/signid/"];
    NSString *string2 = [string1 stringByAppendingString:model.signatureId];
    
    
    AFNetRequest *request = [[AFNetRequest alloc]init];

    __weak typeof(self) weakSelf=self;
    
    request.netSucessBlock=^(id result){
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
    
    
    [request netRequestGetWithUrl:string2 Data:nil];

}

@end




