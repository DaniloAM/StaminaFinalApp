//
//  HomeScreenVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 06/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HomeScreenVC.h"

@interface HomeScreenVC ()

@end

@implementation HomeScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBarNameWith:@"Stamina"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    UserData *user = [UserData alloc];
    [[self nickName] setText:[user nickName]];
    NSString *str = [NSString stringWithFormat:@"icone_calendario_%02ld.png",(long)day];
    [self firstButtonMethod:nil  fromClass:self  withImage:[UIImage imageNamed:str]];
    [self secondButtonMethod:nil fromClass:self  withImage:[UIImage imageNamed:@"icon_compartilhar.png"]];
    [self thirdButtonMethod:nil  fromClass:self withImage:[UIImage imageNamed:@"icon_pontuacao.png"]];
    self.navigationItem.hidesBackButton = YES;
    [self addToButton:_academiaBtn imageWhenPressed:[UIImage imageNamed:@"s_icone_academia.png"] andNormal:[UIImage imageNamed:@"icone_academia.png"]];
    [self addToButton:_runningBtn imageWhenPressed:[UIImage imageNamed:@"s_icone_caminhada.png"] andNormal:[UIImage imageNamed:@"icone_caminhada.png"]];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MenuShouldOpen *temp = [MenuShouldOpen alloc];
    [temp setOpen:YES];
}


@end
