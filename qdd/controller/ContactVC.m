//
//  ContactVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ContactVC.h"
#import "Macro.h"
#import "RESideMenu.h"
#import "NSString+PinYin.h"
#import "AddContactVC.h"

@interface ContactVC()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    UISearchBar *searchBar;
    
    UITableView *myTableView;
    
    NSArray *dataArray;
    
    NSArray  *indexArray;
}

@end

@implementation ContactVC


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
    label.text=@"联系人";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30*WIDTH_SCALE-22, 31, 22, 22)];
    [self.view addSubview:rightButton];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"添加联系人"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self createView];
}


-(void)createView{
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 85*HEIGHT_SCALE)];
    searchBar.delegate=self;
    [self.view addSubview:searchBar];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+85*HEIGHT_SCALE, SCREEN_WIDTH, SCREEN_HEIGHT-64-85*HEIGHT_SCALE)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    
//    [self initDataSource];
    
}



- (void)initDataSource
{
//    NSArray *array = @[@"登记", @"大奔", @"周傅", @"爱德华",@"((((", @"啦文琪羊", @"   s文强", @"过段时间", @"等等", @"各个", @"宵夜**", @"***", @"贝尔",@"*而结婚*", @"返回***", @"你还", @"与非门*", @"是的", @"*模块*", @"*没做*",@"俄文", @"   *#咳嗽", @"6",@"fh",@"C罗",@"邓肯"];
    
    
     NSArray *array = @[@"登记", @"大奔", @"周傅", @"爱德华", @"啦文琪羊", @"   s文强", @"过段时间", @"等等", @"各个", @"宵夜**", @"***", @"贝尔",@"*而结婚*", @"返回***", @"你还", @"与非门*", @"是的", @"*模块*", @"*没做*",@"俄文", @"   *#咳嗽", @"6",@"fh",@"C罗",@"邓肯"];
    
    indexArray = [array arrayWithPinYinFirstLetterFormat];

    
    dataArray =[NSMutableArray arrayWithArray:indexArray];
    
    [myTableView reloadData];
}



#pragma mark--- UITableViewDataSource and UITableViewDelegate Methods---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else{
        NSDictionary *dict = dataArray[section];
        NSMutableArray *array = dict[@"content"];
        return [array count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    NSDictionary *dict = dataArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];
    
    return cell;
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //自定义Header标题
//    UIView* myView = [[UIView alloc] init];
//    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.7];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
//    titleLabel.textColor=[UIColor whiteColor];
//    
//    NSString *title = dataArray[section][@"firstLetter"];
//    titleLabel.text=title;
//    [myView  addSubview:titleLabel];
//    
//    return myView;
//}
//
//




#pragma mark---tableView索引相关设置----
//添加TableView头视图标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = dataArray[section];
    NSString *title = dict[@"firstLetter"];
    return title;
}


//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in dataArray) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}


//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
    }
}






-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}


-(void)showRight{
    AddContactVC *VC = [[AddContactVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
