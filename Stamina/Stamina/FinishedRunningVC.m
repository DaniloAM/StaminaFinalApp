//
//  FinishedRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 30/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "FinishedRunningVC.h"

@interface FinishedRunningVC ()

@end

@implementation FinishedRunningVC

#pragma mark - Receiver

-(void)receiveRunningRoute: (FinishedRoute *)runningRoute {
    
    _route = runningRoute;
    
}

#pragma mark - ViewController methods

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self routeNameTextField] setDelegate:self];
    
    if(_route) {
        [self drawTrajectoryDone];
    }

    [super showBarWithAnimation:true];
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
    
    
    //Set bar button actions and images
    [self firstButtonMethod:@selector(goHome) fromClass:self  withImage:[UIImage imageNamed:@"icon_home.png"]];
    
    [self secondButtonMethod:nil  fromClass:self withImage:[UIImage imageNamed:@"icon_calendario.png"]];
    
    [self thirdButtonMethod:@selector(goToRankingPoints)  fromClass:self withImage:[UIImage imageNamed: @"icone_pontuacao.png"]];
    

    
    //Set buttons images and actions
    [self setButtonImageNameLeft:@"icon_add_unable.png" andRight:@"icon_compartilha_unable.png"];
    
    [self setButtonActionLeft:@selector(enableRouteNameTextField) andRight:@selector(selectSharingOption)];
    
}




-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if(![self isWaitingPicture]) {
        [self saveRouteInformations];
    }
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self routeNameTextField] resignFirstResponder];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}


#pragma mark - Load Trajectory methods

-(void)drawTrajectoryDone {
    
    UIImageView *routeView = _route.routePoints.returnDrawedViewWithCurrentRoute;
    
    
    if(routeView == nil) {
        return;
    }
    
    double fator;
    
    if(routeView.frame.size.width > routeView.frame.size.height) {
        fator = ( 180 / routeView.frame.size.width );
        
    } else {
        fator = ( 180 / routeView.frame.size.height );
        
    }
    
    
    [routeView setFrame:CGRectMake(0, 0, routeView.frame.size.width * fator , routeView.frame.size.height * fator)];
    
    routeView.center = _routeImageView.center;
    
    [_routeImageView removeFromSuperview];
    [self.view addSubview:routeView];
    
    
    [self setTrajectoryInfo];
    
}


-(void)setTrajectoryInfo {
    
    if(_route.distanceInMeters >= 1000.0f) {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%.01f Km", _route.distanceInMeters / 1000]];
    }
    
    else {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%d m", (int) _route.distanceInMeters]];
    }
    
    [[self timeLabel] setText:[NSString stringWithFormat:@"%d:%02d:%02d", (_route.timeInMinutes / 60), (_route.timeInMinutes  % 60), _route.timeInSeconds]];
    
}


#pragma mark - Buttons actions


-(void)setButtonActionLeft: (void *)left andRight: (void *)right {
    
    if([[self leftButton] allTargets] != nil) {
    
    [[self leftButton] removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    [[self rightButton] removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];

    }
        
    [[self leftButton] addTarget:self action:left forControlEvents:UIControlEventTouchUpInside];
    
    [[self rightButton] addTarget:self action:right forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)setButtonImageNameLeft: (NSString *)left andRight: (NSString *)right {
    
    [[self leftButton] setBackgroundImage:[UIImage imageNamed:left] forState:UIControlStateNormal];
    [[self rightButton] setBackgroundImage:[UIImage imageNamed:right] forState:UIControlStateNormal];
    
}


-(void)enableRouteNameTextField {
    
    _saveRoute = true;
    
    [[self routeNameTextField] setHidden:false];
    
    [[self leftButton] setHidden:true];
    [[self rightButton] setHidden:true];
    
    [self thirdButtonMethod:@selector(confirmRouteName) fromClass:self  withImage:[UIImage imageNamed: @"icone_ok.png"]];
}


-(void)confirmRouteName {
    
    
    [[self routeNameTextField] setHidden:true];
    
    [[self leftButton] setHidden:false];
    [[self rightButton] setHidden:false];
    
    if([[[self routeNameTextField] text] isEqualToString:@""]) {
        [self setSaveRoute:false];
    }
    
    [self thirdButtonMethod:@selector(goToRankingPoints) fromClass:self  withImage:[UIImage imageNamed: @"icone_pontuacao.png"]];
    
}


-(void)selectSharingOption {
    
    [self setButtonImageNameLeft:@"icon_trajeto_unable.png" andRight:@"icon_camera_unable.png"];
    [self setButtonActionLeft:nil andRight:@selector(goSharePicture)];
    
}


-(void)rightSlideAction {
    
    
    if(_state == 0) {
        [self.navigationController popViewControllerAnimated:true];
    }
    
    if(_state == 1) {
        _saveRoute = false;
    }
    
    if(_state == 1 || _state == 2) {
       
        [self setButtonImageNameLeft:@"icon_add_unable.png" andRight:@"icon_compartilha_unable.png"];
        
        [self setButtonActionLeft:@selector(enableRouteNameTextField) andRight:@selector(selectSharingOption)];
    }
    

}

-(void)goToCalendar {
    
}

-(void)goToRankingPoints {


}

-(void)goSharePicture {
    
    [self setIsWaitingPicture:true];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"shareScreen"];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}



-(void)goHome {
    
    [self popToRoot];
}



-(void)saveRouteInformations {
    
    NSString *routeName = @"";
    
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSError *error = nil;
    
    
    if(_saveRoute) {
        
        routeName = [[self routeNameTextField] text];
        
        TrajectoryRoute *saveRoute = [NSEntityDescription insertNewObjectForEntityForName:@"TrajectoryRoute" inManagedObjectContext:context];
        
        [saveRoute setPicturesArray:[NSKeyedArchiver archivedDataWithRootObject:_route.arrayOfPictures]];
        [saveRoute setArrayOfLocations:[NSKeyedArchiver archivedDataWithRootObject:_route.arrayOfLocations]];
        
        [saveRoute setTrajectoryName:[[self routeNameTextField] text]];
        [saveRoute setTrajectoryDistance:[NSNumber numberWithDouble:[_route distanceInMeters]]];
        
        UserData *userData = [UserData alloc];
        [[userData routesArray] addObject:saveRoute];
        
        
    }
    
    
    TrajectoryFile *file = [NSEntityDescription insertNewObjectForEntityForName:@"TrajectoryFile" inManagedObjectContext:context];
    
    
    [file setTrajectoryName:routeName];
    [file setDateDone:[NSDate date]];
    [file setDuration:[NSNumber numberWithInt:([_route timeInSeconds] + [_route timeInMinutes] * 60)]];
    [file setDistance:[NSNumber numberWithDouble:[_route distanceInMeters]]];
    
    
    [context save:&error];
    
}



@end
