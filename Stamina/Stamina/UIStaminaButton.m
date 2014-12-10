//
//  UIStaminaButton.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 10/12/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "UIStaminaButton.h"

@implementation UIStaminaButton : UIButton


-(id)initWithStaminaImageName:(NSString *)imageName {
    
    self = [super init];
    
    if(self) {
        
        [self setStaminaImageName:imageName];
        
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s_%@", imageName]] forState:UIControlStateHighlighted];
        
    }
    
    return self;
    
}

-(void)setStaminaImageName: (NSString *)imageName {
    
    [self setStaminaImageName:imageName];
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s_%@", imageName]] forState:UIControlStateHighlighted];
    
}


@end
