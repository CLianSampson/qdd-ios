//
//  PayView.h
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayBlock)();

@interface PayView : UIView

@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UIButton *choose;
@property(nonatomic,strong) UILabel *name;


@property(nonatomic,copy) PayBlock payBlock;

@end
