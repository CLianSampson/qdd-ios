//
//  PhotoVC.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "PhotoVC.h"
#import "Macro.h"

#import "ViewController.h"
#import "FaceDetectVC.h"

@interface PhotoVC()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,assign)int netFlag; //0失败  1成功

@end

@implementation PhotoVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _netFlag=1;
    
    
    [super createNavition];
    self.mytitle.text=@"身份照上传";
    
    
    UIButton *ablam = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-30*WIDTH_SCALE, 31, 60, 22)];
    [self.view addSubview:ablam];
    [ablam setTitle:@"相册" forState:UIControlStateNormal];
    ablam.titleLabel.font=[UIFont systemFontOfSize:16];
    [ablam setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ablam.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [ablam addTarget:self action:@selector(openAblam) forControlEvents:UIControlEventTouchUpInside];

    
    
//    [super createBackgroungView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    label.backgroundColor=RGBColor(209, 209, 209);
    [self.view addSubview:label];

    
    
    [self creteView];
    
}



-(void)creteView{

    UILabel *example = [[UILabel alloc]initWithFrame:CGRectMake(104*WIDTH_SCALE, 66+96*HEIGHT_SCALE, SCREEN_WIDTH-104*WIDTH_SCALE, 13)];
    example.text=@"手持身份证实例";
    example.font=[UIFont boldSystemFontOfSize:13];
    example.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:example];
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(104*WIDTH_SCALE, example.frame.origin.y+example.frame.size.height+20, SCREEN_WIDTH/2-104*WIDTH_SCALE, (20+28+34)*HEIGHT_SCALE+44)];
    backgroundView.backgroundColor=RGBColor(245, 245, 245);
    backgroundView.layer.cornerRadius=6;
    [self.view addSubview:backgroundView];
    
    
    float backgroundWidth = backgroundView.frame.size.width;
    float backgroundHeight = backgroundView.frame.size.height;
    
    _icon =[[UIImageView alloc]initWithFrame:CGRectMake(backgroundWidth/2-54/2, backgroundHeight/2-54/2, 54, 54)];
    _icon.image=[UIImage imageNamed:@"图层-1"];
    [backgroundView addSubview:_icon];
    
    
    UILabel *introduction =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+42*WIDTH_SCALE, backgroundView.frame.origin.y+10*HEIGHT_SCALE, SCREEN_WIDTH/2-42*WIDTH_SCALE, 11)];
    introduction.textColor=RGBColor(136, 136, 136);
    introduction.font=[UIFont systemFontOfSize:11];
    introduction.text=@"手持身份证照上传说明";
    [self.view addSubview:introduction];
    
    
    
    UILabel *one =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+42*WIDTH_SCALE, introduction.frame.origin.y+introduction.frame.size.height+28*HEIGHT_SCALE, SCREEN_WIDTH/2-42*WIDTH_SCALE, 11)];
    one.textColor=RGBColor(136, 136, 136);
    one.font=[UIFont systemFontOfSize:11];
    one.text=@"1、 人物及证件说明清晰可见";
    [self.view addSubview:one];

    
    UILabel *two =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+42*WIDTH_SCALE, one.frame.origin.y+one.frame.size.height+7*HEIGHT_SCALE, SCREEN_WIDTH/2-42*WIDTH_SCALE, 11)];
    two.textColor=RGBColor(136, 136, 136);
    two.font=[UIFont systemFontOfSize:11];
    two.text=@"2、 证件上传格式: jpg、png";
    [self.view addSubview:two];
    

    
    UILabel *three =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+42*WIDTH_SCALE, two.frame.origin.y+two.frame.size.height+7*HEIGHT_SCALE, SCREEN_WIDTH/2-42*WIDTH_SCALE, 11)];
    three.textColor=RGBColor(136, 136, 136);
    three.font=[UIFont systemFontOfSize:11];
    three.text=@"3、  上传文件在2M以内";
    [self.view addSubview:three];
    
    
    UILabel *faceDetect =[[UILabel alloc]initWithFrame:CGRectMake(0, backgroundView.frame.origin.y+backgroundView.frame.size.height+94*HEIGHT_SCALE, SCREEN_WIDTH, 13)];
    faceDetect.textAlignment=NSTextAlignmentCenter;
    faceDetect.text=@"确认信息无误后将进入人脸检测";
    faceDetect.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:faceDetect];
    
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(36*WIDTH_SCALE, faceDetect.frame.origin.y+faceDetect.frame.size.height+78*HEIGHT_SCALE, SCREEN_WIDTH-2*36*WIDTH_SCALE, 81*HEIGHT_SCALE)];
    [confirm setBackgroundImage:[UIImage imageNamed:@"登录按钮"] forState:UIControlStateNormal];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.titleLabel.font=[UIFont systemFontOfSize:18];
    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];

    
    
}


-(void)confirmClick{
//    ViewController *VC =[[ViewController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
    [self addLoadIndicator];
    [self netReauest];
}


-(void)openAblam{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _icon.image=image;
        

    }];
}



-(void)netReauest{
    
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_UPLOAD_PICTURE];
    
    NSString *appendUrlString=[urlstring stringByAppendingString:self.token];
    
    NSLog(@"appendUrlString is : %@",appendUrlString);
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            
            _netFlag = 1;
            
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf sucessDo:result];
            
        }else if ([state isEqualToString:@"fail"]){
            
            _netFlag = 0;
            
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    self.netFailedBlock=^(id result){
        
        _netFlag = 0;
        
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [self upLoad:appendUrlString image:_icon.image];
}


-(void)sucessDo:(id )result{
    
    [self createAlertView];
    self.alertView.title=@"上传图片成功";
    [self.alertView show];
    return;
    
}



//AlertView已经消失时执行的事件,alertView代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (_netFlag == 1) {
        FaceDetectVC *VC =[[FaceDetectVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
   
}


@end
