//
//  SignShowCell.m
//  qdd
//
//  Created by Apple on 17/4/8.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignShowCell.h"
#import "Macro.h"

@implementation SignShowCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        _imageShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addSubview:_imageShow];
        
    }
    
    return self;
}

@end
