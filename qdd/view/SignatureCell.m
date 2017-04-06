//
//  SignatureCell.m
//  qdd
//
//  Created by Apple on 17/4/6.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignatureCell.h"
#import "Macro.h"

@implementation SignatureCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _signImageView = [[SignImageView alloc]initWithFrame:CGRectMake(42*WIDTH_SCALE, 0, 665*WIDTH_SCALE, 285*HEIGHT_SCALE)];
        _signImageView.image =[UIImage imageNamed:@""];
        _signImageView.backgroundColor=RGBColor(241, 241, 241);
        [self addSubview:_signImageView];
        
        
    }
    
    return self;
}


@end
