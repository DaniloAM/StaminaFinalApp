//
//  WebServiceResponse.h
//  TesteServidor
//
//  Created by João Lucas Sisanoski on 17/09/14.
//  Copyright (c) 2014 João Lucas Sisanoski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserTraining.h"
#import "TrainingExercises.h"
#import "AppDelegate.h"
#import "UserData.h"
#import "WeatherObject.h"
@interface WebServiceResponse : NSObject
+(NSString*)cadastrarComNome: (NSString *)nome eSenha: (NSString *)password email: (NSString *)email sexo:(BOOL) sexo nickName: (NSString *)nickName;
+(NSString*)loginComEmailOuNickName: (NSString *)anything eSenha: (NSString *)password;
+(NSString*)inserirExercicioComId: (int )idExercicio serie: (int )serie repeticoes: (int )repeticoes treino: (int )treino emailOrNickName: (NSString *)anything;
+(NSString *)upToServerTraining: (UserTraining *) newTraining withLogin: (NSString *)login withPassword: (NSString *)password;
+(NSString*)getJsonComNickName: (NSString *)anything eSenha: (NSString *)password;
+(NSString*)checkStart: (NSString *)email eSenha: (NSString *)password;
+(NSString*)atualizaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade;
+(NSString*)criaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade;

+(WeatherObject *)previsaoDoTempoNaLatitude : (float)lat eLongitude:(float)lon;

@end
