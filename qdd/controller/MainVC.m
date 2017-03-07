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
#import "RightVC.h"
#import "SignCell.h"

@interface MainVC()<UITableViewDelegate,UITableViewDataSource>
{
    float buttonOrginalY;
    float buttonWidth;
}


@property(nonatomic,strong)UIScrollView *scrolView;

@property(nonatomic,strong)UIButton *waitForMe;
@property(nonatomic,strong)UIButton *waitForOther;
@property(nonatomic,strong)UIButton *complete;
@property(nonatomic,strong)UIButton *timeOut;

@property(nonatomic,strong)UILabel *underLabel;


@property(nonatomic,strong)UITableView *myTableView;


@end

@implementation MainVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
   
}

-(void)viewDidLoad{
    self.view.backgroundColor=RGBColor(233, 233, 233);

    
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
    _label.font=[UIFont systemFontOfSize:17];
    
    [self.view addSubview:_label];
    
    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*3, 120)];
    _scrolView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_scrolView];
    
    [self creatView];
    
}



-(void)creatView{
    
    buttonWidth = (SCREEN_WIDTH-60*5*WIDTH_SCALE)/4;
    buttonOrginalY = _scrolView.frame.origin.y+_scrolView.frame.size.height;
    
    _waitForMe  =[[UIButton alloc]initWithFrame:CGRectMake(60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_waitForMe setTitle:@"待我签署" forState:UIControlStateNormal];
    _waitForMe.titleLabel.font=[UIFont systemFontOfSize:10];
    [_waitForMe setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForMe addTarget:self action:@selector(waitForMeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_waitForMe];
    
    
    _waitForOther = [[UIButton alloc]initWithFrame:CGRectMake(_waitForMe.frame.origin.x+_waitForMe.frame.size.width+60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_waitForOther setTitle:@"待别人签署" forState:UIControlStateNormal];
    _waitForOther.titleLabel.font=[UIFont systemFontOfSize:9];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_waitForOther addTarget:self action:@selector(waitForOtherMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_waitForOther];
    
    
    _complete = [[UIButton alloc]initWithFrame:CGRectMake(_waitForOther.frame.origin.x+_waitForOther.frame.size.width+60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_complete setTitle:@"已完成" forState:UIControlStateNormal];
    _complete.titleLabel.font=[UIFont systemFontOfSize:9];
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_complete addTarget:self action:@selector(completeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_complete];
    
    _timeOut = [[UIButton alloc]initWithFrame:CGRectMake(_complete.frame.origin.x+_complete.frame.size.width+60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    [_timeOut setTitle:@"过期未签署" forState:UIControlStateNormal];
    _timeOut.titleLabel.font=[UIFont systemFontOfSize:9];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut addTarget:self action:@selector(timeOutMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeOut];
    
//    _underLabel = [[UILabel alloc]initWithFrame:CGRectMakeCGRectMake(60*WIDTH_SCALE, buttonOrginalY, buttonWidth, 89*HEIGHT_SCALE)];
    
    _underLabel = [[UILabel alloc]initWithFrame:CGRectMake(60*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2)];
    [_underLabel setBackgroundColor:RGBColor(0, 51, 192)];
    [self.view addSubview:_underLabel];
    
    
    UIView *background  =[[UIView alloc]initWithFrame:CGRectMake(0, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.backgroundColor=RGBColor(200, 200, 200);
    [self.view addSubview:background];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20*WIDTH_SCALE, _underLabel.frame.origin.y+_underLabel.frame.size.height, SCREEN_WIDTH-2*20*WIDTH_SCALE, SCREEN_HEIGHT-_underLabel.frame.origin.y-_underLabel.frame.size.height)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor=RGBColor(200, 200, 200);
    [self.view addSubview:_myTableView];
    
}


-(void)waitForMeMethod{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(60*WIDTH_SCALE, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
     [_waitForMe setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];

    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];


    
    
}

-(void)waitForOtherMethod{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(60*WIDTH_SCALE+_waitForMe.frame.origin.x+_waitForMe.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    
    [_waitForOther setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
}

-(void)completeMethod{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(60*WIDTH_SCALE+_waitForOther.frame.origin.x+_waitForOther.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    [_complete setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_timeOut setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
}

-(void)timeOutMethod{
    [UIView animateWithDuration:0.5 animations:^{
        _underLabel.frame=CGRectMake(60*WIDTH_SCALE+_complete.frame.origin.x+_complete.frame.size.width, buttonOrginalY+89*HEIGHT_SCALE-2, buttonWidth, 2);
    }];
    
    [_timeOut setTitleColor:RGBColor(0, 51, 192) forState:UIControlStateNormal];
    [_complete setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    
    [_waitForMe setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    [_waitForOther setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
}





#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

- (SignCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SignCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.layer.cornerRadius=3;
    cell.clipsToBounds=YES;
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
    
    RightVC *vc = [[RightVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)click{
    NSLog(@"button click sucess");
    self.block(@"chenlian");
    AFNetRequest *request = [[AFNetRequest alloc]init];
    [request getMethod];
}

@end
