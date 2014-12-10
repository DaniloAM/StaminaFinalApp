//
//  TemporaryVC.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 18/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TemporaryVC.h"

@interface TemporaryVC ()

@end

@implementation TemporaryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
        [super viewDidLoad];
}
-(UserTraining *)criaTemporario{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    UserTraining *user = [[UserTraining alloc] init];
    NSError *error = nil;
    [user setExercisesArray:[NSMutableArray array]];
    [user setName:@"Temporario"];
    for(int x = 0 ; x < 20; x++){
        TrainingExercises *temp = [NSEntityDescription insertNewObjectForEntityForName:@"TrainingExercises" inManagedObjectContext:context];
        [temp setSeries:[NSNumber numberWithInt:x]];
        [temp setRepetitions:[NSNumber numberWithInt:x*10]];
        [temp setId_exercise:[NSNumber numberWithInt:x]];
        [temp setTraining_name:[user name]];
        [[user exercisesArray] addObject:temp];
        [context save:&error];
    }
    return user;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
