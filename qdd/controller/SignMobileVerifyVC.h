//
//  SignMobileVerifyVC.h
//  qdd
//
//  Created by Apple on 17/4/17.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"

@interface SignMobileVerifyVC : BaseVC

@property(nonatomic,strong)NSString *phoneNum;

@property(nonatomic,strong)NSString *signId;

@property(nonatomic,assign)int signStatus;  //0 个人签章  1授权签章



@end
