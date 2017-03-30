//
//  BaseVC.h
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetRequest.h"
#import "MJRefresh.h"
#import "StringUtil.h"
#import "TimeUtil.h"

typedef void (^NetSucessBlock)(id result);
typedef void (^NetFailedBlock)(id result);

typedef void (^PictureBlock)(id result);



@interface  BaseVC : UIViewController<UIAlertViewDelegate>



@property(nonatomic,strong)UIAlertView *alertView;


@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel *mytitle;

@property(nonatomic,copy)NetSucessBlock netSucessBlock;
@property(nonatomic,copy)NetFailedBlock netFailedBlock;
@property(nonatomic,copy)PictureBlock pictureBlock;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;

@property(nonatomic,strong)NSString *token;


-(void)createBackgroungView;

-(void)createAlertView;

-(void)createNavition;


-(void)showLeft;


-(void)netRequestWithUrl:(NSString *)url Data:(id )data;

-(void)netRequestGetWithUrl:(NSString *)url Data:(id )data;

- (void)downLoad:(NSString *)urlString;

-(void)addLoadIndicator;

-(void)upLoad:(NSString *)urlString image:(UIImage *)image;

@end
