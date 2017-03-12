//
//  AccountCell.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AccountCell.h"
#import "Macro.h"

@implementation AccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        float heigth = 107*HEIGHT_SCALE;
        
        _leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 0, SCREEN_WIDTH/2-30*WIDTH_SCALE, heigth)];
        _leftLabel.font=[UIFont systemFontOfSize:14];
        _leftLabel.textColor=RGBColor(51, 51, 51);
        [self addSubview:_leftLabel];
        
        
        _rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 0, SCREEN_WIDTH/2-52*WIDTH_SCALE+50, heigth)];
        _rightLabel.font=[UIFont systemFontOfSize:14];
        _rightLabel.textColor=RGBColor(51, 51, 51);
        _rightLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_rightLabel];

        
    }
    
    return self;
}

@end
