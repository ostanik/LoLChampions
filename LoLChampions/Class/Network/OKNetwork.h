//
//  OKNetwork.h
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**
 *  Classe responsavel por fazer a comunicação com API do League of Legends
 */
@interface OKNetwork : AFHTTPSessionManager {
    NSString *url;
}

/**
 *  Construtor singleton da classe
 *
 *  @return retorna a instancia da classe
 */
+(OKNetwork *)lolAPI;

/**
 *  Metodo assincrono que retorna uma listagem dos campeões da API do League of Legends
 *  já realizando a persistencia de dados.
 *
 *  @param completion    callBack de sucesso no post
 *  @param errorCallback callback de erro no post
 */
-(void) getChampions:(void (^)())completion
             onError:(void (^)(NSError *error)) errorCallback;

@end
