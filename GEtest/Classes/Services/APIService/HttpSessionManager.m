//
//  HttpSessionManager.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "HttpSessionManager.h"

#import "HttpSessionManager.h"

@implementation HttpSessionManager

#pragma mark - INIT

+ (HttpSessionManager *)sharedHTTPSessionManagerWithBaseUrl:(NSString *)baseURL {
    static HttpSessionManager *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSString *)url {
    
    self = [super initWithBaseURL:[NSURL URLWithString:url]];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        /*--Uncomment if methods e.g Delete need to have body in request--*/
        //self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET",@"HEAD",nil];
    }
    
    return self;
}


#pragma mark - Public GET/POST

- (void)getDataFromResource:(NSString *)resource parameters:(id)parameters success:(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {

    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, resource]];

    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            BOOL isFailure = [self checkIsFailure:error.code];
            if (isFailure) {
                failure([error.userInfo objectForKey:kGEHttpSessionManagerErrorMessage]);
            }else{
                failure(nil);
            }
        } else {
            if (success) {
                success (responseObject);
            }
        }
    }];
    [dataTask resume];
}

-(BOOL)checkIsFailure: (NSInteger ) statusCode{
    
    if (statusCode == KNoUpdatesError) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Override Methods

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse *, id, NSError *))originalCompletionHandler
{
    
    return [super dataTaskWithRequest:request
                    completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                        
                        // If there's an error, store the response in it if we've got one.
                        NSError *formatError = [self formatErrorWithOriginalError:error responseObject:responseObject];
                        
                        // Call the original handler.
                        if (originalCompletionHandler) {
                            originalCompletionHandler(response, responseObject, formatError);
                        }
                    }];
}

#pragma mark - Private Methods

- (NSError *)formatErrorWithOriginalError:(NSError *)error responseObject:(id)responseObject {
    
    if (!error) {
        return nil;
    }
    if (responseObject) {
        // error from server dute to wrong requests
        NSString *errorMessage = responseObject[@"message"]?responseObject[@"message"]:error.localizedDescription;
        NSInteger code = [responseObject[@"code"] integerValue];
        
        return [NSError errorWithDomain:kGEHttpSessionManagerErrorDomain
                                   code:code
                               userInfo:@{kGEHttpSessionManagerErrorMessage:errorMessage}];
        
    }else {
        //server technical problem...
        return [NSError errorWithDomain:kGEHttpSessionManagerErrorDomain
                                   code:error.code
                               userInfo:@{kGEHttpSessionManagerErrorMessage:error.localizedDescription}];
        
    }
}

@end
