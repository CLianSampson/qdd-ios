//
//  MainVC.h
//  MuchMoney
//
//  Created by Apple on 16/12/17.
//  Copyright © 2016年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"

typedef void(^MyBlock)(NSString *);

@interface MainVC : BaseVC

@property(nonatomic,copy) MyBlock block;


@end
