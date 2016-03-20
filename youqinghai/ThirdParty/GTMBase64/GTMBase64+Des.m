//
//  GTMBase64+Des.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "GTMBase64+Des.h"
#import "GTMBase64.h"

#define YQH_DEBUGMODEL @"eVfcMiA="
#define YQH_RELEASEMODEL @"swimQingHaiAPP="

static NSString *const DESEncrypt_Key     = YQH_DEBUGMODEL;
static NSString *const DESEncrypt_IV      = @"{12, 22, 32, 43, 51, 64, 57, 98}";

@implementation GTMBase64 (DES)

#pragma mark - AES

+ (NSString *)desEncrypt:(NSString *)plainText
{
    return [[self class] des:plainText
                      desKey:DESEncrypt_Key
                       desIV:DESEncrypt_IV
                   operation:kCCEncrypt];
}

+ (NSString *)desDecrypt:(NSString *)encryptText
{
    return [[self class] des:encryptText
                      desKey:DESEncrypt_Key
                       desIV:DESEncrypt_IV
                   operation:kCCDecrypt];
}

+ (NSString *)des:(NSString*)text
           desKey:(NSString *)desKey
            desIV:(NSString *)desIV
        operation:(CCOperation)operation
{
    if(!text || !desKey){
        return nil;
    }
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (operation == kCCDecrypt) {
        //解密
        NSData *encryptData = [GTMBase64 decodeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
        //NSData *encryptData = [[text dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
        plainTextBufferSize = [encryptData length];
        vplainText = [encryptData bytes];
    }
    else {
        //加密
        NSData* decryptData = [text dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [decryptData length];
        vplainText = (const void *)[decryptData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = (uint8_t *)malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *cDesKey = (const void *)[desKey UTF8String];
    const void *cDesIV = (const void *)[desIV UTF8String];
    
    ccStatus = CCCrypt(operation,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding,
                       cDesKey,
                       kCCKeySizeDES,
                       cDesIV,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus) {} //NO warning
    NSString *result;
    
    if (operation == kCCDecrypt) {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
        
        if(!result){
            result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                   length:(NSUInteger)movedBytes]
                                           encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
    }
    else {
        NSData *desData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:desData];
        //result = [desData base64EncodedStringWithOptions:0];
    }
    
    free(bufferPtr);
    
    return result;
}

@end
