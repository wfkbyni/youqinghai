//
//  RequestBaseAPI.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"
#import "ResponseBaseData.h"

#define RequestUrl @""

@implementation RequestBaseAPI

#pragma mark - 基本
- (void)setHeadersForRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer withParametersLength:(NSInteger)length{
    
   
    //[requestSerializer setValue:[@(timeInterval) stringValue] forHTTPHeaderField:@"timestamp"];
}

#pragma mark - 基础请求
- (RACSignal *)requestWithType:(RequestAPIType)type
                           url:(NSString *)url
                       timeout:(NSTimeInterval)timeout
                        params:(NSDictionary *)params{
    
    if (type < RequestAPITypeGet || type > RequestAPITypeGet) {
        NSError *error = [NSError errorWithDomain:@"请求类型异常" code:-1001 userInfo:nil];
        return [RACSignal error:error];
    }
    RACSignal *resultSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSInteger length = 0;
        NSDictionary *restParams = [self restParamsForOriginalParam:params length:&length];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [self setHeadersForRequestSerializer:manager.requestSerializer withParametersLength:length];
        if (timeout > 0) {
            [manager.requestSerializer setTimeoutInterval:timeout];
        }
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        YQHLog(@"Request -->\n" "URL:  %@\n" "Headers:\n%@\n" "Parameters:\n%@\n",urlString,manager.requestSerializer.HTTPRequestHeaders,params);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        switch (type) {
            case RequestAPITypeGet: {
                NSURLSessionDataTask *task = [manager GET:urlString parameters:restParams progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    
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
                NSURLSessionDataTask *task = [manager POST:urlString parameters:restParams progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
            YQHLog(@"Response  -->\n" "URL:  %@\n" "error:\n%@\n", task.currentRequest.URL, error);
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
            YQHLog(@"Response  -->\n" "URL:  %@\n" "error:\n%@\n", task.currentRequest.URL, error);
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
    //解析结果
    YQHLog(@"Response  -->\n" "URL:  %@\n" "data:\n%@\n", task.currentRequest.URL, responseObject);
    ResponseBaseData *responseBaseData = [ResponseBaseData mj_objectWithKeyValues:responseObject];
    if (responseBaseData.result_code == 0) {
        [subscriber sendNext:responseBaseData.result_data];
        [subscriber sendCompleted];
    }
    else{
        
        NSError *error = [NSError errorWithDomain:@"数据响应异常" code:responseBaseData.result_code userInfo:responseObject];
        [subscriber sendError:error];
    }
}


@end
