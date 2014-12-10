//
//  Cadastro.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 01/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "Cadastro.h"

@implementation Cadastro
+(Cadastro *)sharedStore{
    static Cadastro *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
    
}

+(id) allocWithZone: (struct _NSZone *) zone{
    
    return [self sharedStore];
    
}
@end
