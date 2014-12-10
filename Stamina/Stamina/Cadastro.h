//
//  Cadastro.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 01/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cadastro : NSObject
+(Cadastro *)sharedStore;
@property NSString *nome;
@property NSString *nick;
@property NSString *email;
@property NSString *senha;
@property float peso;
@property int altura;
@property BOOL sexo;
@property int idade;
@property BOOL should;
@property NSString *stringResposta;
@end
