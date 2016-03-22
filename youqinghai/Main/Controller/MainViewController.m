//
//  MainViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"

@interface MainViewController()

@property (nonatomic, strong) MainViewModel *mainViewModel;

@end

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mainViewModel = [[MainViewModel alloc] init];
    
    [[self.mainViewModel getHomePageData] subscribeNext:^(id x) {
       
        YQHLog(@"resopnse: %@", x);
        
    }];
}

@end
