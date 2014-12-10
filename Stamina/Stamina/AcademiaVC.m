//
//  AcademiaVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "AcademiaVC.h"

@interface AcademiaVC ()

@end

@implementation AcademiaVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [self firstButtonMethod:@selector(function1) fromClass:self withImage:[UIImage imageNamed:@"icon_home.png"]];
    [self secondButtonMethod:@selector(function2) fromClass:self  withImage:[UIImage imageNamed:@"icon_adicionar.png"]];
    [self thirdButtonMethod:@selector(function3) fromClass:self  withImage:[UIImage imageNamed:@"icon_editar.png"]];
    [self showBarWithAnimation:1];
    }
-(void)function1{
    
    [self popToRoot];
}
-(void)function2{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CriaTreino"];
    
    [self.navigationController pushViewController:myVC animated:YES];
}
-(void)function3{

}
-(IBAction)callCalendar{
    [self callViewWithName:@"Calendario"];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSString *str = [NSString stringWithFormat:@"icone_calendario_%02d.png", (int)day];
    [self.navigationItem setTitle:@"Academia"];
    [[self btnCalendar] setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    [self btn1].backgroundColor = [UIColor staminaBlackColor];
    [self btn2].backgroundColor = [UIColor staminaBlackColor];
    [[self btn1].titleLabel setFont:[UIFont fontWithName:@"Lato" size:22.0]];
    [[self btn2].titleLabel setFont:[UIFont fontWithName:@"Lato" size:22.0]];
    [[self btn1].titleLabel setTextColor:[UIColor staminaYellowColor]];
    [[self btn2].titleLabel setTextColor:[UIColor staminaYellowColor]];
}
@end
