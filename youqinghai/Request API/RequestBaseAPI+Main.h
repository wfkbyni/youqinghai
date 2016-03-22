//
//  RequestBaseAPI+Main.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

@interface RequestBaseAPI (Main)

/**
 *  @brief 获取首页数据
 *
 *  @param mark      mark 传入  分页时候传入 1
 *  @param pageIndex 页码    （用于推荐线路分页）
 *  @param pageSize  页大小
 *
 */
- (RACSignal *)getHomePageDataWithMark:(NSInteger)mark withPageIndex:(NSInteger)pageIndex withPageSize:(NSInteger)pageSize;

@end
