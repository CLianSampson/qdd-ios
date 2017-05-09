//
//  SignImageView.m
//  qdd
//
//  Created by Apple on 17/2/26.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignImageView.h"
#import "Macro.h"

@implementation SignImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.layer.cornerRadius=6;
        
        self.userInteractionEnabled = YES;
        
        _unChooseImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-20*WIDTH_SCALE-18, 20*HEIGHT_SCALE, 18, 18)];
        _unChooseImage.image =[ UIImage imageNamed:@"未选中圆点按钮"];
        [self addSubview:_unChooseImage];
        
        _chooseImage = [[UIImageView alloc]initWithFrame:CGRectMake(_unChooseImage.frame.origin.x+4.5, _unChooseImage.frame.origin.y+4.5, 9, 9)];
        _chooseImage.image=[UIImage imageNamed:@"选中圆点"];
//        [self addSubview:_chooseImage];
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-(25+110)*WIDTH_SCALE, self.frame.size.height-(32+44)*HEIGHT_SCALE, 110*WIDTH_SCALE, 44*HEIGHT_SCALE)];
        _deleteButton.backgroundColor = BlueRGBColor;
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _deleteButton.layer.cornerRadius = 5;
//        [self addSubview:_deleteButton];
        
    }
    
    return self;
}


-(void)deleteClick:(UIButton *)sender{
    [self.deleteSignatureDelegate deleteSignature:sender];
}

@end





