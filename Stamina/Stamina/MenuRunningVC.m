//
//  MenuRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 28/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "MenuRunningVC.h"

@interface MenuRunningVC ()

@end

@implementation MenuRunningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date = [NSDate date];
     NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay fromDate:date];
    
    [[self calendarButton] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icone_calendario_%02d.png", (int) comp.day]] forState:UIControlStateNormal];

    
    UISwipeGestureRecognizer *backGest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToHomeScreen)];
    
    backGest.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:backGest];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self performSelectorInBackground:@selector(showCurrentWeather) withObject:nil];
}


-(void)showCurrentWeather {
    
    WeatherCondition *condition = [[WeatherCondition alloc] init];
    
    NSInteger temperature = [condition returnTemperatureInCurrentLocation];
    
    if(temperature <= 0) {
        CGRect frame = [[self calendarButton] frame];
        frame.origin.x = 118;
        [[self calendarButton] setFrame:frame];
        [[self temperatureLabel] setHidden:true];
        [[self temperatureImage] setHidden:true];
        
    }
    
    else {
        CGRect frame = [[self calendarButton] frame];
        frame.origin.x = 60;
        [[self calendarButton] setFrame:frame];
        [[self temperatureLabel] setHidden:false];
        [[self temperatureImage] setHidden:false];
        
        temperature -= 273;
        
        NSString *temp = [NSString stringWithFormat:@"%d °C", (int) temperature];
        [[self temperatureLabel] setText:temp];
    }
    
    
    [self performSelector:@selector(showCurrentWeather) withObject:nil afterDelay:30.0];
    
}


-(void)backToHomeScreen {
    
    [self popToRoot];
    
}

-(IBAction)callCalendar {
    [self callViewWithName:@"Calendario"];
}


@end
