//
//  OrderCell.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "OrderCell.h"
#import "Macro.h"


@implementation OrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        UILabel *upperBackground = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 30*HEIGHT_SCALE)];
        upperBackground.backgroundColor=RGBColor(245, 245, 245);
        [self addSubview:upperBackground];
        
        
        _type = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, upperBackground.frame.origin.y+45*HEIGHT_SCALE, 200, 13)];
        _type.textColor=RGBColor(0, 0, 0);
        _type.text=@"套餐类型:   个人套餐A";
        [self addSubview:_type];
        
        
        _timeDuration = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-56*WIDTH_SCALE-200, 45*HEIGHT_SCALE, 200, 11)];
        _timeDuration.textColor=RGBColor(255, 182, 184);
        _timeDuration.text=@"有效期: 永久";
        _timeDuration.textAlignment=NSTextAlignmentRight;
        [self addSubview:_timeDuration];
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, _type.frame.origin.y+13+38*HEIGHT_SCALE, SCREEN_WIDTH, 12)];
        _price.text=@"价格: 100元";
        _price.textColor=RGBColor(0, 0, 0);
        [self addSubview:_price];
        
        _useTimes = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, _price.frame.origin.y+_price.frame.size.height+30*HEIGHT_SCALE, 200, 12)];
        _useTimes.text=@"可使用次数: 10次";
        [self addSubview:_useTimes];
        
        _signDuration = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200-56*WIDTH_SCALE, _price.frame.origin.y+_price.frame.size.height+30*HEIGHT_SCALE, 200, 11)];
        _signDuration.textAlignment=NSTextAlignmentRight;
        _signDuration.text=@"签约有效期: 15天";
        [self addSubview:_signDuration];
        
        
        UILabel *middleBackgroubd = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, _useTimes.frame.origin.y+_useTimes.frame.size.height+32*HEIGHT_SCALE, SCREEN_WIDTH-56*2*WIDTH_SCALE, 1)];
        middleBackgroubd.backgroundColor=RGBColor(209, 209, 209);
        [self addSubview:middleBackgroubd];
        
        _orderId = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, middleBackgroubd.frame.origin.y+middleBackgroubd.frame.size.height+32*HEIGHT_SCALE, SCREEN_WIDTH, 12)];
        _orderId.text=@"订单编号: 20170305111111";
        [self addSubview:_orderId];
        
        _orderTime = [[UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, _orderId.frame.origin.y+_orderId.frame.size.height+32*HEIGHT_SCALE, SCREEN_WIDTH, 12)];
        _orderTime.text = @"下单时间: 2017-08-08 10:13:13";
        [self addSubview:_orderTime];
        
        UILabel *underBackGround =[[ UILabel alloc]initWithFrame:CGRectMake(56*WIDTH_SCALE, _orderTime.frame.origin.y+_orderTime.frame.size.height+32*HEIGHT_SCALE, SCREEN_WIDTH-56*2*WIDTH_SCALE, 1)];
        underBackGround.backgroundColor=RGBColor(209, 209, 209);
        [self addSubview:underBackGround];
        
        
       
        _pay = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-56*WIDTH_SCALE-20-58, underBackGround.frame.origin.y+(117*HEIGHT_SCALE-28)/2, 58, 28)];
        [_pay setTitle:@"去付款" forState:UIControlStateNormal];
        [_pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pay setBackgroundImage:[UIImage imageNamed:@"去付款按钮"] forState:UIControlStateNormal];
        [_pay addTarget:self action:@selector(payMoney) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_pay];

    }
    
    return self;
}


-(void)payMoney{
    [self.delegate payMoney];
}

@end
