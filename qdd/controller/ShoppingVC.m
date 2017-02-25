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
    //     self.automaticallyAdjustsScrollViewInsets=false;
}

-(void)viewDidLoad{
    self.navigationItem.title=@"消息";
    
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左面返回箭头"] style:UIBarButtonItemStyleBordered target:self action:@selector(showLeft)];
    //
    //    self.navigationItem.backBarButtonItem=item;
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"购买套餐";
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 76*HEIGHT_SCALE)];
    backgroundLabel.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:backgroundLabel];
    
    
    UILabel *mySet = [[UILabel alloc]initWithFrame:CGRectMake(27*WIDTH_SCALE, 64+26*HEIGHT_SCALE, 100, 13*SCALE)];
    mySet.text=@"我的套餐";
    mySet.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:mySet];
    
    
    
    UILabel *setType = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, backgroundLabel.frame.origin.y+76*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
    setType.text=@"套餐类型:  个人套餐A";
    setType.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:setType];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-54*WIDTH_SCALE-300, backgroundLabel.frame.origin.y+76*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
    time.text=@"有效期:  永久";
    time.font=[UIFont systemFontOfSize:16];
    time.textColor=RGBColor(65, 65, 65);
    time.textAlignment=UITextAlignmentRight;
    [self.view addSubview:time];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, setType.frame.origin.y+92*HEIGHT_SCALE, SCREEN_WIDTH-108*WIDTH_SCALE, 1)];
    line.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:line];
    
    
    
    UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, setType.frame.origin.y+92*HEIGHT_SCALE, SCREEN_WIDTH-108*WIDTH_SCALE, 92*HEIGHT_SCALE)];
    total.text=@"总次数:  10次      剩余次数:  4次";
    total.textColor=RGBColor(65, 65, 65);
    [self.view addSubview:total];
    
    
    
    UILabel *shoppingBack = [[UILabel alloc]initWithFrame:CGRectMake(0, total.frame.origin.y+92*HEIGHT_SCALE, SCREEN_WIDTH, 100*HEIGHT_SCALE)];
    shoppingBack.text=@"   套餐购买";
    shoppingBack.backgroundColor=RGBColor(247, 247, 247);
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
   
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}



-(void)jumpDetail:(int)setId{
    ShoppingDetailVC *VC = [[ShoppingDetailVC alloc]init];
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:transition forKey:nil];
    
    VC.setId=setId;
//    [self presentViewController:VC animated:YES completion:^{
//        
//    }];
    
    [self.navigationController pushViewController:VC animated:YES];

}


@end
