//
//  CarDetailController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarDetailController.h"
#import "CarViewModel.h"

#import "DriverCarHeaderView.h"
#import "DriverCarPivViewTableViewCell.h"
#import "DriverCarCommentTableViewCell.h"
#import "DriverCarIntroduceTableViewCell.h"

@interface CarDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CarViewModel *carViewModel;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) DriverCarHeaderView *driverCarHeaderView;

@end

#define DriverCarPivViewCell @"DriverCarPivViewCell"
#define DriverCarCommentViewCell @"DriverCarCommentViewCell"
#define DriverCarIntroduceCell @"DriverCarIntroduceTableViewCell"

@implementation CarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _carViewModel = [[CarViewModel alloc] init];
    _carViewModel.driverId = self.car.Id;
    [[_carViewModel getDriverCarDetails] subscribeNext:^(id x) {
        
    }];
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [_myTableView registerClass:[DriverCarPivViewTableViewCell class] forCellReuseIdentifier:DriverCarPivViewCell];
    [_myTableView registerClass:[DriverCarCommentTableViewCell class] forCellReuseIdentifier:DriverCarCommentViewCell];
    [_myTableView registerClass:[DriverCarIntroduceTableViewCell class] forCellReuseIdentifier:DriverCarIntroduceCell];
    
    [_myTableView setTableHeaderView:[self commonView]];
    
    UIButton *charteredBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) + 7, kScreenSize.width, 60)];
    [charteredBtn setBackgroundColor:[UIColor orangeColor]];
    [charteredBtn setTitle:@"我要包车" forState:UIControlStateNormal];
    [self.view addSubview:charteredBtn];
}

- (UIView *)commonView{
    if (!_driverCarHeaderView) {
        _driverCarHeaderView = [[DriverCarHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 250)];
        [self.view addSubview:_driverCarHeaderView];
        
        @weakify(self)
        [_driverCarHeaderView setBtnClickEvent:^(BtnClickEvent event) {
            @strongify(self)
            switch (event) {
                case BtnClickEventWithBack: {
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                case BtnClickEventWithCollection: {
                    
                    break;
                }
            }
        }];
    }
    
    return _driverCarHeaderView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 170.0f;
            break;
        case 1:
            return 140.0f * 3 + 90;
            break;
        default:
            break;
    }
    
    return 170.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            DriverCarPivViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarPivViewCell];
            if (!cell) {
                cell = [[DriverCarPivViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarPivViewCell];
            }
            
            return cell;
        }
            break;
        case 1:
        {
            DriverCarCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarCommentViewCell];
            if (!cell) {
                cell = [[DriverCarCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarCommentViewCell];
            }
            
            return cell;
        }
            break;
        case 2:
        {
            DriverCarIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarIntroduceCell];
            if (!cell) {
                cell = [[DriverCarIntroduceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarIntroduceCell];
            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    DriverCarPivViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarPivViewCell];
    if (!cell) {
        cell = [[DriverCarPivViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarPivViewCell];
    }
    
    return cell;
}

@end
