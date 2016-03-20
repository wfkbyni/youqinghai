//
//  GTMBase64+Des.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "GTMBase64.h"

#import <CommonCrypto/CommonCryptor.h>

@interface GTMBase64 (DES)
+ (NSString *)desEncrypt:(NSString *)plainText;

+ (NSString *)desDecrypt:(NSString *)encryptText;

+ (NSString *)des:(NSString*)text
           desKey:(NSString *)desKey
            desIV:(NSString *)desIV
        operation:(CCOperation)operation;

@end