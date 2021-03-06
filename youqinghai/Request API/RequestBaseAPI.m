//
//  RequestBaseAPI.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"
#import "ResponseBaseData.h"
#import "GTMBase64+Des.h"

#define RequestUrl @"http://www.sinata.cn:9402/swimQinghai/"

@implementation RequestBaseAPI

+(instancetype)standardAPI{
    static RequestBaseAPI *requestBaseAPI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestBaseAPI = [[[self class] alloc] init];
    });
    
    return requestBaseAPI;
}


- (NSString *)getDesEncryptWithString:(NSString *)value{
    return [GTMBase64 desEncrypt:value];
}

#pragma mark - 基本
- (void)setHeadersForRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer withParametersLength:(NSInteger)length{
    
   
    //[requestSerializer setValue:[@(timeInterval) stringValue] forHTTPHeaderField:@"timestamp"];
}

#pragma mark - 基础请求
- (RACSignal *)requestWithType:(RequestAPIType)type
                        params:(NSString *)params{
    
    if (type < RequestAPITypeGet || type > RequestAPITypePost) {
        NSError *error = [NSError errorWithDomain:@"请求类型异常" code:-1001 userInfo:nil];
        return [RACSignal error:error];
    }
    RACSignal *resultSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSInteger length = 0;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [self setHeadersForRequestSerializer:manager.requestSerializer withParametersLength:length];

        [manager.requestSerializer setTimeoutInterval:30];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        NSDictionary *dic = @{@"key":params};
        NSString *urlString = [[NSString stringWithFormat:@"%@app.server",RequestUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        YQHLog(@"\n\n\nRequest -->\n" "请求地址%@\n" "Parameters:明文参数  %@\nParameters:加密参数  %@\n\n\n",urlString,[GTMBase64 desDecrypt:params],params);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        switch (type) {
            case RequestAPITypeGet: {
                NSURLSessionDataTask *task = [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    [self processResponseObject:responseObject forTask:task subscriber:subscriber];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    YQHLog(@"Response  -->\n" "URL:  %@\n" "error:\n%@\n", task.currentRequest.URL, error);
                    if (!error) {
                        error = [NSError errorWithDomain:@"请求失败" code:-1001 userInfo:nil];
                    }
                    [subscriber sendError:error];
                }];
                return [RACDisposable disposableWithBlock:^{
                    [task cancel];
                }];
            }
            case RequestAPITypePost: {
                NSURLSessionDataTask *task = [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self processResponseObject:responseObject forTask:task subscriber:subscriber];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    YQHLog(@"\n\n\n响应结果：Response  -->" "URL:  %@\n" "error:\n%@\n\n\n", task.currentRequest.URL, error);
                    if (!error) {
                        error = [NSError errorWithDomain:@"请求失败" code:-1001 userInfo:nil];
                    }
                    [subscriber sendError:error];
                }];
                return [RACDisposable disposableWithBlock:^{
                    [task cancel];
                }];
            }
            default: {
                return nil;
            }
        }
    }];
    return resultSignal;
}

#pragma mark - 上传附件
- (RACSignal *)postApiString:(NSString *)apiString
                      params:(NSDictionary *)params
                   attachKey:(NSString *)attachKey
                  attachData:(NSData *)attachData{
    RACSignal *resultSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSInteger length = 0;
        NSDictionary *restParams = [self restParamsForOriginalParam:params length:&length];
        NSString *urlString = [RequestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [self setHeadersForRequestSerializer:manager.requestSerializer withParametersLength:length];
        manager.responseSerializer             = [AFJSONResponseSerializer serializer];
        NSURLSessionDataTask *task = [manager POST:urlString parameters:restParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFormData:attachData name:attachKey];
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [self processResponseObject:responseObject forTask:task subscriber:subscriber];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            YQHLog(@"\n\n\n响应结果：Response  -->" "URL:  %@\n" "error:\n%@\n\n\n", task.currentRequest.URL, error);
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return resultSignal;
}

- (RACSignal *)postApiString:(NSString *)apiString
                      params:(NSDictionary *)params
               multiAttaches:(NSArray *)attaches{
    RACSignal *resultSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSInteger length = 0;
        NSDictionary *restParams = [self restParamsForOriginalParam:params length:&length];
        NSString *urlString     = [RequestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [self setHeadersForRequestSerializer:manager.requestSerializer withParametersLength:length];
        manager.responseSerializer             = [AFJSONResponseSerializer serializer];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSURLSessionDataTask *task = [manager POST:urlString parameters:restParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (NSDictionary *attach in attaches) {
                [formData appendPartWithHeaders:attach[@"headers"] body:attach[@"data"]];
            }
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [self processResponseObject:responseObject forTask:task subscriber:subscriber];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            YQHLog(@"\n\n\n响应结果：Response  -->" "URL:  %@\n" "error:\n%@\n\n\n", task.currentRequest.URL, error);
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return resultSignal;
}

#pragma mark - 其他
- (NSDictionary *)restParamsForOriginalParam:(NSDictionary *)params length:(NSInteger *)length{
    NSDictionary *restParams = nil;
    *length = 0;
    if (params && params.count > 0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        restParams = @{@"body":paramsStr};
        *length = paramsStr.length;
    }
    return restParams;
}

- (void)processResponseObject:(id)responseObject
                      forTask:(NSURLSessionDataTask *)task
                   subscriber:(id<RACSubscriber> )subscriber{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    ResponseBaseData *responseBaseData = [ResponseBaseData mj_objectWithKeyValues:responseObject];
    if (responseBaseData.result_code == 0) {
        
        NSString *string = responseBaseData.result_data;
        
        NSString *value = [GTMBase64 desDecrypt:string];
        
        //解析结果
        YQHLog(@"\n\n\n响应结果：Response  -->" "URL:  %@\n" "value:\n%@\n\n\n", task.currentRequest.URL, value);
        
        [subscriber sendNext:value];
        [subscriber sendCompleted];
    }
    else{
        NSError *error = [NSError errorWithDomain:@"数据响应异常" code:responseBaseData.result_code userInfo:responseObject];
        [subscriber sendError:error];
    }
}


@end
