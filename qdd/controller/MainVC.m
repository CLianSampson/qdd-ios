//
//  MainVC.m
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "MainVC.h"
#import "AFNetRequest.h"

@implementation MainVC

-(void)viewDidLoad{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor=[UIColor redColor];
    [self.view addSubview:label];
    
    
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
    
    self.block=^(NSString *name){
        NSLog(@"name is : %@",name);
    };
}


-(void)click{
    NSLog(@"button click sucess");
    self.block(@"chenlian");
    AFNetRequest *request = [[AFNetRequest alloc]init];
    [request getMethod];
}

@end
