//
//  OrderCell.h
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol payMoneyProtocol <NSObject>

-(void)payMoney:(id) sender;

@end


@interface OrderCell : UITableViewCell

@property(nonatomic,strong) UILabel *type;
@property(nonatomic,strong) UILabel *timeDuration;

@property(nonatomic,strong) UILabel *price;
@property(nonatomic,strong) UILabel *useTimes;
@property(nonatomic,strong) UILabel *signDuration;

@property(nonatomic,strong) UILabel *orderId;
@property(nonatomic,strong) UILabel *orderTime;

@property(nonatomic,strong) UIButton *pay;

@property(nonatomic,assign) id<payMoneyProtocol> delegate;


@end
