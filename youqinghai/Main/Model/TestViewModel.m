//
//  TestViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TestViewModel.h"
#import "RequestBaseAPI+User.h"

@implementation TestViewModel

-(RACSignal *)registerUser{
    return [[RequestBaseAPI standardAPI] userRegisterWithPhone:@"15680608061" withPassword:@"123456" withCode:@"111111" withType:UserRegisterTypeWithRegister];
}

@end
