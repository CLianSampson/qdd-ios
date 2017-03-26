//
//  TimeUtil.h
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject


+(long)transStringToTimestap:(NSString *)timeString;


+(NSString *)transDateFormate:(NSString *) timeStr;


@end
