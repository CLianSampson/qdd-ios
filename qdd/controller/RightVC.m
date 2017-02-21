//
//  RightVC.m
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "RightVC.h"
#import "Macro.h"
#import "MessageCell.h"

@implementation RightVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
//     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    self.navigationItem.title=@"消息";
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左面返回箭头"] style:UIBarButtonItemStyleBordered target:self action:@selector(showLeft)];
//    
//    self.navigationItem.backBarButtonItem=item;
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"消息";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    

}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableView dataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return 10;
}


- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    
    return cell;
}


#pragma mark -tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    return;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",(48+32+26+28+50)*HEIGHT_SCALE);
    NSLog(@"%f",HEIGHT_SCALE);
    return (48+32+26+28+50)*HEIGHT_SCALE;
}




@end
