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

@property(nonatomic,strong)UILabel *setType;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *total ;
@property(nonatomic,strong)SetView *one;
@property(nonatomic,strong)SetView *two;
@property(nonatomic,strong)SetView *three;






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
    
    
    
    _setType = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, backgroundLabel.frame.origin.y+backgroundLabel.frame.size.height+26*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
//    _setType.text=@"套餐类型:  个人套餐A";
    _setType.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_setType];
    
    
    
    _time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-54*WIDTH_SCALE-300, backgroundLabel.frame.origin.y+backgroundLabel.frame.size.height+26*HEIGHT_SCALE, 300, 92*HEIGHT_SCALE)];
//    _time.text=@"有效期:  永久";
    _time.font=[UIFont systemFontOfSize:12];
    _time.textColor=RGBColor(65, 65, 65);
    _time.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:_time];
    
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, _setType.frame.origin.y+_setType.frame.size.height+1, SCREEN_WIDTH-108*WIDTH_SCALE, 1)];
    line.backgroundColor=SepreateRGBColor;
    [self.view addSubview:line];
    
    
    
    _total = [[UILabel alloc]initWithFrame:CGRectMake(54*WIDTH_SCALE, _setType.frame.origin.y+_setType.frame.size.height+2, SCREEN_WIDTH-108*WIDTH_SCALE, 92*HEIGHT_SCALE)];
//    _total.text=@"总次数:  10次      剩余次数:  4次";
    _total.textColor=RGBColor(65, 65, 65);
    _total.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:_total];
    
    
    
    UILabel *shoppingBack = [[UILabel alloc]initWithFrame:CGRectMake(0, _total.frame.origin.y+92*HEIGHT_SCALE, SCREEN_WIDTH, 100*HEIGHT_SCALE)];
    shoppingBack.text=@"   套餐购买";
    shoppingBack.backgroundColor=RGBColor(247, 247, 247);
    shoppingBack.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:shoppingBack];

    
    
    //三个套餐的宽度
    float setWidth = (SCREEN_WIDTH-(57*2+50*2)*WIDTH_SCALE)/3;
    _one = [[SetView alloc]initWithFrame:CGRectMake(57*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:_one];
    
    
    _two = [[SetView alloc]initWithFrame:CGRectMake(_one.frame.origin.x+setWidth+50*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:_two];
    
    _three = [[SetView alloc]initWithFrame:CGRectMake(_two.frame.origin.x+setWidth+50*WIDTH_SCALE, shoppingBack.frame.origin.y+100*HEIGHT_SCALE+30, setWidth, 62+66*HEIGHT_SCALE)];
    [self.view addSubview:_three];
    
    
    _one.delegate=self;
    _two.delegate=self;
    _three.delegate=self;

    
    [self netRequest];
    
}




-(void)showLeft{
    
    [self.sideMenuViewController setContentViewController:self.VC];
    [self.sideMenuViewController hideMenuViewController];
}



-(void)jumpDetail:(int)setId{
    ShoppingDetailVC *VC = [[ShoppingDetailVC alloc]init];
    
    
    VC.setId=setId;
    VC.token =self.token;
    
    [self.navigationController pushViewController:VC animated:YES];

}


-(void)netRequest{
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_BUY_GOODS];
    
    [urlstring appendString:self.token];
    [urlstring appendString:@"/"];
    [urlstring appendString:@"p/2"];
    
    
    __weak typeof(self) weakSelf=self;
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
    request.netSucessBlock=^(id result){
                
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf doSucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    request.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestGetWithUrl:urlstring Data:nil];

}

-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    
    NSString *allNum = [data objectForKey:@"allnum"];
    if ([StringUtil isNullOrBlank:allNum]) {
        allNum = @" ";
    }
    NSString *goodName = [data objectForKey:@"goodname"];
    if ([StringUtil isNullOrBlank:goodName]) {
        goodName = @" ";
    }
    NSString *remainTimes = [data objectForKey:@"last_name"];
    if ([StringUtil isNullOrBlank:remainTimes]) {
        remainTimes = @" ";
    }
    NSString *termiteTime = [data objectForKey:@"time"];
    if ([StringUtil isNullOrBlank:termiteTime]) {
        termiteTime = @" ";
    }
    
    
    _setType.text = goodName;
    _time.text = termiteTime;
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:@"总次数:  "];
    [mutableString appendString:allNum];
    [mutableString appendString:@"剩余次数:  "];
    [mutableString appendString:remainTimes];
    [mutableString appendString:@"次"];
    _total.text = mutableString;
    
    
    NSArray *arry = [data objectForKey:@"goods"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有套餐信息";
        [self.alertView show];
    }else{
       
        for(int i=0;i<3;i++){
            NSDictionary *dic = arry[i];
            if (0==i) {
                
                NSString *price =[ dic objectForKey:@"price"];
                
                _one.content.text = [dic objectForKey:@"contents"];
                _one.type.text = [dic objectForKey:@"name"];
                
                NSMutableString *mutableString = [[NSMutableString alloc]initWithString:price];
                [mutableString appendString:@"/"];
                [mutableString appendString:[dic objectForKey:@"num"]];
                [mutableString appendString:@"次"];
                _one.times.text = mutableString;
                
                _one.setId = [[dic objectForKey:@"id"] intValue];
            }
            
            if (1==i) {
                NSString *price =[ dic objectForKey:@"price"];
                
                _two.content.text = [dic objectForKey:@"contents"];
                _two.type.text = [dic objectForKey:@"name"];
                
                NSMutableString *mutableString = [[NSMutableString alloc]initWithString:price];
                [mutableString appendString:@"/"];
                [mutableString appendString:[dic objectForKey:@"num"]];
                [mutableString appendString:@"次"];
                _two.times.text = mutableString;
                
                _two.setId = [[dic objectForKey:@"id"] intValue];

            }
            
            if (2==i) {
                NSString *price =[ dic objectForKey:@"price"];
                
                _three.content.text = [dic objectForKey:@"contents"];
                _three.type.text = [dic objectForKey:@"name"];
                
                NSMutableString *mutableString = [[NSMutableString alloc]initWithString:price];
                [mutableString appendString:@"/"];
                [mutableString appendString:[dic objectForKey:@"num"]];
                [mutableString appendString:@"次"];
                _three.times.text = mutableString;
                
                _three.setId = [[dic objectForKey:@"id"] intValue];

            }
            
        }
    }
    
}



@end
