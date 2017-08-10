//
//  SignShowVC.h
//  qdd
//
//  Created by Apple on 17/4/2.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//



#import "BaseVC.h"


typedef void(^RefuseSignBlock)();

@interface SignShowVC : BaseVC

@property(nonatomic,strong)UIViewController *VC;

@property(nonatomic,strong)NSString *signTitle;

@property(nonatomic,strong)NSString *signId;

@property(nonatomic,assign)SIGN_STATE signState;


@property(nonatomic,copy)RefuseSignBlock refuseSignBlock;



@end
