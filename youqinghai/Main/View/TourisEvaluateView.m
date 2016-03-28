//
//  TourisEvaluateView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourisEvaluateView.h"
#import "TourisEvaluateCell.h"

@interface TourisEvaluateView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSArray *tourisEvaluates;

@end

#define cellIdeitifier @"TourisEvaluateCell"

@implementation TourisEvaluateView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _myTableView = [[UITableView alloc] initWithFrame:frame];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        
        [self addSubview:_myTableView];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"TourisEvaluateCell" bundle:nil] forCellReuseIdentifier:cellIdeitifier];
        
        [self.myTableView setEstimatedRowHeight:100];
    }
    
    return self;
}

- (void)setTourisEvaluate:(NSArray *)tourisEvaluate{
    _tourisEvaluates = tourisEvaluate;
    
    [self.myTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tourisEvaluates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TourisEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdeitifier forIndexPath:indexPath];
    
    cell.tourisEvaluate = _tourisEvaluates[indexPath.row];
    
    return cell;
}

@end
