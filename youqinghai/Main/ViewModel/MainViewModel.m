//
//  MainViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MainViewModel.h"
#import "RequestBaseAPI+Main.h"

#import "HomePageData.h"

#define userId 4

@implementation MainViewModel

-(instancetype)init{
    if (self = [super init]) {
        self.mark = 1;
    }
    return self;
}

-(RACSignal *)getHomePageData{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getHomePageDataWithMark:self.mark withPageIndex:1 withPageSize:20]
                         map:^id(id value) {
        
        self.homePageData = [HomePageData mj_objectWithKeyValues:value];
        
        return self.homePageData;
    }];
    
    return signal;
}

-(RACSignal *)getTouristroutesList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTouristroutesListWithTypeId:self.typeId wihtPageIndex:1 withPageSize:20] map:^id(id value) {
        
        self.recommends = [Recommend mj_objectArrayWithKeyValuesArray:value];
        
        return self.recommends;
    }];
    
    return signal;
}

-(RACSignal *)getTourisDetails{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTourisDetailsWithTourisId:self.typeId withUserId:userId] map:^id(id value) {
       
        self.traveltrip = [Traveltrip mj_objectWithKeyValues:value];
        
        return self.traveltrip;
    }];
    
    return signal;
}


@end
