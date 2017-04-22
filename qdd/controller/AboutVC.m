//
//  AboutVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AboutVC.h"
#import "Macro.h"
#import "HelpListVC.h"
#import "CommentVC.h"


@interface AboutVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation AboutVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"关于";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    [self createView];
    
    
}


-(void)createView{
    [self createBackgroungView];
    
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-62)/2, 64+35*HEIGHT_SCALE, 62, 74)];
    icon.image=[UIImage imageNamed:@"签多多-V1.0"];
    [self.view addSubview:icon];
    
    
//    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, icon.frame.origin.y+icon.frame.size.height+20*HEIGHT_SCALE, 200, 12)];
//    version.textColor=RGBColor(51, 51, 51);
//    version.text=@"签多多 V1.0";
//    [self.view addSubview:version];
    
    
    UILabel *underLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, icon.frame.origin.y+icon.frame.size.height+58*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    underLabel.backgroundColor=RGBColor(252, 252, 252) ;
    [self.view addSubview:underLabel];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, underLabel.frame.origin.y+1, SCREEN_WIDTH, 40*2)];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.scrollEnabled=NO;
    _myTableView.backgroundColor=[UIColor whiteColor];
    [self .view addSubview:_myTableView];
}



#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"帮助";
            break;
            
        case 1:
            cell.textLabel.text=@"意见反馈";
            break;
            
            
        default:
            break;
    }
    
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (indexPath.row==0) {
         HelpListVC  *VC=[[HelpListVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    
    }else if (indexPath.row==1){
        CommentVC *VC = [[CommentVC alloc]init];
        VC.token=self.token;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
