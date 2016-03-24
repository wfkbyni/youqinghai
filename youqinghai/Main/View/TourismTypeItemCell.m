//
//  TourismTypeItemCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismTypeItemCell.h"

@interface TourismTypeItemCell()

@property (weak, nonatomic) IBOutlet UIButton *typeImgUrlBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLab;
@end

@implementation TourismTypeItemCell

-(void)awakeFromNib{
    [self viewWithCornerRadius:5];
}

-(void)setTourismType:(TourismType *)tourismType{
 
    [self.typeImgUrlBtn sd_setImageWithURL:[NSURL URLWithString:tourismType.typeImgUrl] forState:UIControlStateNormal placeholderImage:nil];
    
    NSString *typeName = [tourismType.typeName stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    [self.typeNameLab setText:typeName];
}

@end
