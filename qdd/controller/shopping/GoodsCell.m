//
//  GoodsCell.m
//  qdd
//
//  Created by sampson on 2017/7/17.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "GoodsCell.h"
#import "Macro.h"

@implementation GoodsCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
//        _priceLabel.text = @"100元／1次";
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.layer.borderWidth = 1;
        _priceLabel.layer.borderColor = GrayRGBColor.CGColor;
        _priceLabel.layer.cornerRadius = 5;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_priceLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.frame.origin.x + _priceLabel.frame.size.width + 10, 7, SCREEN_WIDTH-130, 15)];
//        _title.text = @"套餐A";
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:_titleLabel];
        
        
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.frame.origin.x + _priceLabel.frame.size.width + 10, 22, SCREEN_WIDTH-130, 15)];
//        _title.text = @"一次100，买不了吃亏，买不了上当";
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_subTitleLabel];
        

    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
