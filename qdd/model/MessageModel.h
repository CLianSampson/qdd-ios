//
//  MessageModel.h
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *contents;
@property(nonatomic,strong)NSString *status;


@end
