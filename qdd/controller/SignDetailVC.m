//
//  SignDetailVC.m
//  qdd
//
//  Created by Apple on 17/4/2.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignDetailVC.h"
#import "SignContentCell.h"

@interface SignDetailVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *sendMobile;
@property(nonatomic,strong)NSString *sendMail;

@property(nonatomic,strong)NSString *toMobile;
@property(nonatomic,strong)NSString *toMail;



@end

@implementation SignDetailVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self createNavition];
    
    self.mytitle.text=@"详情";
    
    [self creteView];
    
}



-(void)creteView{
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];
    
    
    UIView *backgroundView  =[[UIView alloc]initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT-66)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66 + 22*HEIGHT_SCALE, SCREEN_WIDTH,2*( (26+25+18)*HEIGHT_SCALE+28))] ;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [self addLoadIndicator];
    [self netReauest];
                                                                                                                 
}



#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(SignContentCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SignContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SignContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if (indexPath.row==0) {
        cell.icon.image=[UIImage imageNamed:@"发送-(1)"];
        cell.send.text=_sendMobile;
        cell.mail.text=_sendMail;
    }else if (indexPath.row==1){
        cell.icon.image=[UIImage imageNamed:@"接收"];
        cell.send.text=_toMobile;
        cell.mail.text=_toMail;
    }
    
    
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (26+18+25)*HEIGHT_SCALE+28;
}








-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)netReauest{
    AFNetRequest *request = [[AFNetRequest alloc]init];

    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_SIGN_DETAIL];
    [urlstring appendString:self.token];
    [urlstring appendString:@"/id/"];
    [urlstring appendString:_signId];
    
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
    
   
    _sendMobile = [data objectForKey:@"smobile"];
    if ([StringUtil isNullOrBlank:_sendMobile]) {
        _sendMobile = @"";
    }
    _sendMail = [data objectForKey:@"smail"];
    if ([StringUtil isNullOrBlank:_sendMail]) {
        _sendMail = @"";
    }

    _toMobile = [data objectForKey:@"tmobile"];
    if ([StringUtil isNullOrBlank:_toMobile]) {
        _toMobile = @"";
    }
    _toMail = [data objectForKey:@"tmail"];
    if ([StringUtil isNullOrBlank:_toMail]) {
        _toMail = @"";
    }

    [_tableView reloadData];
}

@end
