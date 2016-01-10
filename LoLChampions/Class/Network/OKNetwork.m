//
//  OKNetwork.m
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

#import "OKNetwork.h"
#import <CoreData/CoreData.h>
#import "LolCHampions-Swift.h"

@implementation OKNetwork

+(OKNetwork *)lolAPI
{
    static OKNetwork *_lolAPI = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lolAPI = [[self alloc] init];
    });
    
    return _lolAPI;
}

- (instancetype)init {
    NSString *apiURL = NSLocalizedString(@"SERVER", nil);
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    apiURL = [apiURL stringByAppendingString:[app.config objectForKey:@"APIKey"]];
    
    self = [super initWithBaseURL:[NSURL URLWithString:apiURL]];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer  = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

-(void) getChampions:(void (^)())completion
             onError:(void (^)(NSError *error)) errorCallback {
    
    url = [self.baseURL.absoluteString stringByAppendingString:@"&champData=info"];
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        OKCoreDataManager *cdManager = [[OKCoreDataManager alloc] init];
        [cdManager removeAllData];
        
        for (NSString *objKey in dic){
            [cdManager saveChampion:[dic objectForKey:objKey]];
            [cdManager saveChampInfo:[[dic objectForKey:objKey] objectForKey:@"info"]
                          identifier:[[dic objectForKey:objKey] objectForKey:@"id"]
                           champName:[[dic objectForKey:objKey] objectForKey:@"name"]];
        }
        
        completion();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCallback(error);
    }];
}

@end
