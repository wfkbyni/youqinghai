//
//  MainViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MainViewModel.h"
#import "RequestBaseAPI+Main.h"

@implementation MainViewModel

-(instancetype)init{
    if (self = [super init]) {
        self.mark = 1;
    }
    return self;
}


-(RACSignal *)getHomePageData{
    
    RACSignal *signal = [[RequestBaseAPI standardAPI] getHomePageDataWithMark:self.mark withPageIndex:1 withPageSize:20];
    
    [signal subscribeNext:^(id x) {
        
    }];
    
    return signal;
}

@end