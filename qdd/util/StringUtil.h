//
//  StringUtil.h
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject


+(BOOL)isNullOrBlank:(NSString *)string;

+(BOOL)isPhoneNum:(NSString *)mobileNum;

@end
