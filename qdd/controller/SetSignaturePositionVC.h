//
//  SetSignaturePositionVC.h
//  qdd
//
//  Created by Apple on 17/4/21.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "BaseVC.h"

@interface SetSignaturePositionVC : BaseVC


@property(nonatomic,strong)NSString *signId; //合同id

@property(nonatomic,strong)NSString *signTitle; //合同名称

@property(nonatomic,strong)UIImage *personaSignaturelImage; //个人签章图片

@property(nonatomic,strong)UIImage *enterpriseSignatureImage; //企业签章图片

@property(nonatomic,strong)NSString *personaSignaturelId; //个人签章id

@property(nonatomic,strong)NSString *enterpriseSignatureId; //企业签章id

@property(nonatomic,assign)int signStatus; //签章状态   0，个人签署，1授权签署

@end
