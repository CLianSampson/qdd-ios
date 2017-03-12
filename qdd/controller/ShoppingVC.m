//
//  ShoppingVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ShoppingVC.h"
#import "Macro.h"
#import "SetView.h"
#import "ShoppingDetailVC.h"
#import "RESideMenu.h"

@interface ShoppingVC ()<SetDelegate>
{
    
    
}
@end


@implementation ShoppingVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
  
}

-(void)viewDidLoad{
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"购买套餐";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    
    
    
    
    UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 76*HEIGHT_SCALE)];
    backgroundLabel.backgroundColor=SepreateRGBColor;
    [self.view addSubview:backgroundLabel];
    
    
    UILabel *mySet = [[UILabel alloc]initWithFrame:CGRectMake(27*WIDTH_SCALE, 64+26*HEIGHT_SCALE, 100, 13)];
    mySet.text=@"我的套餐";
    mySet.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:mySet];
    
    
    
    UILabel *setType = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, backgroundLabel.frame.origin.y+backgroundLabel.frame.size.height+26*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
    setType.text=@"套餐类型:  个人套餐A";
    setType.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:setType];
    
    
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-54*WIDTH_SCALE-300, backgroundLabel.frame.origin.y+backgroundLabel.frame.size.height+26*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
    time.text=@"有效期:  永久";
    time.font=[UIFont systemFontOfSize:12];
    time.textColor=RGBColor(65, 65, 65);
    time.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:time];
    
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, setType.frame.origin.y+setType.frame.size.height+1, SCREEN_WIDTH-108*WIDTH_SCALE, 1)];
    line.backgroundColor=SepreateRGBColor;
    [self.view addSubview:line];
    
    
    
    UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, setType.frame.origin.y+setType.frame.size.height+2, SCREEN_WIDTH-108*WIDTH_SCALE, 92*HEIGHT_SCALE)];
    total.text=@"总次数:  10次      剩余次数:  4次";
    total.textColor=RGBColor(65, 65, 65);
    total.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:total];
    
    
    
    UILabel *shoppingBack = [[UILabel alloc]initWithFrame:CGRectMake(0, total.frame.origin.y+92*HEIGHT_SCALE, SCREEN_WIDTH, 100*HEIGHT_SCALE)];
    shoppingBack.text=@"   套餐购买";
    shoppingBack.backgroundColor=RGBColor(247, 247, 247);
    shoppingBack.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:shoppingBack];

    
    
    //三个套餐的宽度
    float setWidth = (SCREEN_WIDTH-(57*2+50*2)*WIDTH_SCALE)/3;
    SetView *one = [[SetView alloc]initWithFrame:CGRectMake(57*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:one];
    
    
    SetView *two = [[SetView alloc]initWithFrame:CGRectMake(one.frame.origin.x+setWidth+50*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:two];
    
    SetView *three = [[SetView alloc]initWithFrame:CGRectMake(two.frame.origin.x+setWidth+50*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:three];
    
    
    one.delegate=self;
    two.delegate=self;
    three.delegate=self;

    
    one.setId=1;
    two.setId=2;
    three.setId=3;
    
}




-(void)showLeft{
    
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}



-(void)jumpDetail:(int)setId{
    ShoppingDetailVC *VC = [[ShoppingDetailVC alloc]init];
    
    
    VC.setId=setId;
    
    [self.navigationController pushViewController:VC animated:YES];

}


@end
