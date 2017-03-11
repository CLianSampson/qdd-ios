//
//  RegisteCell.h
//  qdd
//
//  Created by Apple on 17/3/9.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteCell : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UITextField *textField;


@property(nonatomic,strong)UIButton *smsCode;
@property(nonatomic,strong)UIImageView *verfyCode;

@property(nonatomic,strong)UILabel *change;


@property(nonatomic,strong)NSString *value;
@end
