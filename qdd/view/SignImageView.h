//
//  SignImageView.h
//  qdd
//
//  Created by Apple on 17/2/26.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteSignatureDelegate <NSObject>

-(void)deleteSignature:(UIButton *)sender;

@end

@interface SignImageView : UIImageView


@property(nonatomic,strong) UIImageView *unChooseImage; //未选中按钮

@property(nonatomic,strong) UIImageView *chooseImage; //选中按钮

@property(nonatomic,strong) UIButton *deleteButton; //删除按钮

@property(nonatomic,assign) id<DeleteSignatureDelegate>  deleteSignatureDelegate;

@end
