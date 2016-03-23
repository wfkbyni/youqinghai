//
//  RequestBaseAPI+Main.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Main.h"

NSString *const getHomePageData = @"app/homepage/getHomePageData";

@implementation RequestBaseAPI (Main)

-(RACSignal *)getHomePageDataWithMark:(NSInteger)mark withPageIndex:(NSInteger)pageIndex withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&mark=%ld&pageIndex=%ld&pageSize=%ld",getHomePageData,mark,pageIndex,pageSize];
    params = [GTMBase64 desEncrypt:params];
    
    params = [params stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
    return [self requestWithType:RequestAPITypePost params:params];
}
@end

