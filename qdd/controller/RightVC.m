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
    self.navigationController.navigationBarHidden=NO;
     self.automaticallyAdjustsScrollViewInsets=NO;
}

-(void)viewDidLoad{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-30) style:UITableViewStyleGrouped];
    [self.view addSubview:tabelView];
    tabelView.delegate=self;
    tabelView.dataSource=self;
    
    tabelView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
//    label.text=@"消息";
//    label.textAlignment=UITextAlignmentCenter;
//    label.font=[UIFont systemFontOfSize:17];
//    [self.view addSubview:label];
//    
//    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
//    [self.view addSubview:leftButton];
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"个人"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
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
