//
//  MenuLViews.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 12/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "MenuLViews.h"
@implementation MenuLViews
+(MenuLViews *)sharedStore{
    static MenuLViews *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
    
}
+(id) allocWithZone: (struct _NSZone *) zone{
    
    return [self sharedStore];
    
}
@end
