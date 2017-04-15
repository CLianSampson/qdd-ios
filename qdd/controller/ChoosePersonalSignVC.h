//
//  ChooseSignVC.h
//  qdd
//
//  Created by Apple on 17/4/15.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"

@interface ChoosePersonalSignVC : BaseVC

@property(nonatomic,assign)int signId; //合同id
@property(nonatomic,strong)NSString *signatureId; //签章id

@property(nonatomic,assign)int status; //合同签署状态 0：本人签署 1：授权签署

@end
