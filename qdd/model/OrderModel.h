//
//  OrderModel.h
//  qdd
//
//  Created by Apple on 17/3/26.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,strong)NSString *systemId;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *creatTime;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *endTime;


@end
