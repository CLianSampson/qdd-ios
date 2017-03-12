//
//  BaseVC.h
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController



@property(nonatomic,strong)UIAlertView *alertView;





@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel *mytitle;


-(void)createBackgroungView;

-(void)createAlertView;

-(void)createNavition;


-(void)showLeft;

@end
