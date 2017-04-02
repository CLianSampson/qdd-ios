//
//  MySignVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MySignVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "SignVC.h"
#import "SignImageView.h"
#import "SignatureModel.h"

@interface MySignVC()

@property(nonatomic,strong)NSMutableArray *mutableArry;

@end

@implementation MySignVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
   
    
    
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
    addButton.titleLabel.textAlignment=NSTextAlignmentRight;
    addButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *upper = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    upper.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:upper];

    
    UILabel *backGround = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 20*HEIGHT_SCALE)];
    backGround.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backGround];
    
    
    
    UILabel *under = [[UILabel alloc]initWithFrame:CGRectMake(0, backGround.frame.origin.y+backGround.frame.size.height+1, SCREEN_WIDTH, 1)];
    under.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:under];
    
    //按32号字体算
    UILabel *personSign = [[UILabel alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, backGround.frame.origin.y+backGround.frame.size.height+28*HEIGHT_SCALE, SCREEN_WIDTH-42*WIDTH_SCALE, 29)];
    
    personSign.text=@"个人签章";
    personSign.font=[UIFont boldSystemFontOfSize:16];
    [self.view addSubview:personSign];
    
    SignImageView *signImageView = [[SignImageView alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, personSign.frame.origin.y+personSign.frame.size.height+28*HEIGHT_SCALE, 665*WIDTH_SCALE, 285*HEIGHT_SCALE)];
    signImageView.image =[UIImage imageNamed:@""];
    signImageView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:signImageView];
    
    [self netReauest];
    
}


-(void)add{
    SignVC *vc = [[SignVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}


-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_LIST_SIGNATURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
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
    
    [self netRequestGetWithUrl:appendUrlString Data:nil];
}


-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"allsign"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有签章";
        [self.alertView show];
        return;
    }
    
    
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




@end
