//
//  UIView+Helper.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

-(void)viewWithCornerRadius:(int)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
