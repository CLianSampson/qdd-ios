//
//  TimeUtil.m
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+(long)transStringToTimestap:(NSString *)timeString{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [formatter dateFromString:timeString]; //------------将字符串按formatter转成nsdate
    
    
    //NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    long timeStap = (long)[date timeIntervalSince1970];
    return timeStap;

}



//将返回的 "yyyy-MM-dd HH:mm:ss" 的格式转换为 yyyyMMddHHmmss格式
+(NSString *)transDateFormate:(NSString *) timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [formatter dateFromString:timeStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}



@end
