//
//  ConfirmOrderController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ConfirmOrderController.h"

#import "RelationView.h"

@interface ConfirmOrderController ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) RelationView *relationView;

@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.00]];
    
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:self.relationView];
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenSize.width, 1000)];
}

- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    }
    return _myScrollView;
}

-(RelationView *)relationView{
    
    if (!_relationView) {
        _relationView = [[RelationView alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width, 250)];
    }
    
    return _relationView;
}


@end
