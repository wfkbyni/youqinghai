//
//  DriverCarIntroduceTableViewCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarIntroduceTableViewCell.h"
#import "DriverCarCellHeaderView.h"

@interface DriverCarIntroduceTableViewCell()

@property (nonatomic, strong) DriverCarCellHeaderView *headerView;

@property (nonatomic, strong) UIView *introduceView;
@end

@implementation DriverCarIntroduceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headerView];
        
        [self addSubview:self.introduceView];
        
    }
    return self;
}

- (DriverCarCellHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[DriverCarCellHeaderView alloc] initWithFrame:CGRectZero withImageName:@"collection_off" withTitle:@"个人介绍"];
    }
    
    return _headerView;
}

- (UIView *)introduceView{
    
    if (!_introduceView) {
        _introduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 100)];
    }
    
    return  _introduceView;
}

@end
