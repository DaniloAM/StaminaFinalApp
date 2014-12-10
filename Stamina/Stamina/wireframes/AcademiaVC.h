//
//  AcademiaVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"

@interface AcademiaVC : HideBBVC 
@property UIView *tabBar;
@property CGPoint point;
@property CGPoint startPointBar;
@property (weak, nonatomic) IBOutlet UIImageView *iconCalendar;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;
@end
