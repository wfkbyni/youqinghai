//
//  BaseViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "BaseViewController.h"
#import "TestViewModel.h"

@interface BaseViewController ()

@property (nonatomic, strong) TestViewModel *testViewModel;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _testViewModel = [[TestViewModel alloc] init];
    [[_testViewModel registerUser] subscribeNext:^(id x) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setEditing:YES];
}

@end
