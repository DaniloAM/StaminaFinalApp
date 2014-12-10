//
//  WebServiceResponse.m
//  TesteServidor
//
//  Created by João Lucas Sisanoski on 17/09/14.
//  Copyright (c) 2014 João Lucas Sisanoski. All rights reserved.
//

#import "WebServiceResponse.h"

@implementation WebServiceResponse
+(NSString*)cadastrarComNome: (NSString *)nome eSenha: (NSString *)password email: (NSString *)email sexo:(BOOL) sexo nickName: (NSString *)nickName {
    email = [email lowercaseString];
    nickName = [nickName lowercaseString];
    
    NSString *url = @"http://54.207.112.185/joao/cadastro.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&nome=%@&email=%@&sexo=%d&nickname=%@",password, nome, email, sexo, nickName];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)loginComEmailOuNickName: (NSString *)anything eSenha: (NSString *)password{
    anything = [anything lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/login.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&emailOrNick=%@",password, anything];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)getJsonComNickName: (NSString *)anything eSenha: (NSString *)password{
    anything = [anything lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/getJson.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&emailOrNick=%@",password, anything];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)inserirExercicioComId: (int )idExercicio serie: (int )serie repeticoes: (int )repeticoes treino: (int )treino emailOrNickName: (NSString *)anything{
    anything = [anything lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/insereExercicio.php";
    NSString *post = [NSString stringWithFormat:@"emailOrNick=%@&id_exercicio=%d&series=%d&repeticoes=%d&treino=%d",anything, idExercicio,serie,repeticoes,treino];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}

+(NSString *)doTheRequest :(NSString *)post andUrl: (NSString *)url{
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* s = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    return s;
}


+(NSString *)upToServerTraining: (UserTraining *) newTraining withLogin: (NSString *)login withPassword: (NSString *)password {
    login = [login lowercaseString];
    UserTraining *temp = newTraining;
    NSArray *array = [temp exercisesArray];
    NSMutableArray *trainingsArray = [NSMutableArray array];
    for (int x = 0; x < [array count]; x++) {
        TrainingExercises *temp = [array objectAtIndex:x];
        NSDictionary *trainingDictionary =[NSDictionary dictionaryWithObjectsAndKeys:
                                           [temp id_exercise], @"id_exercise",
                                           [temp training_name], @"trainingName",
                                           [temp series], @"series",
                                           [temp repetitions], @"repetitions",
                                           nil];
        [trainingsArray addObject:trainingDictionary];
    }
    NSError *error = nil;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:trainingsArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    return [WebServiceResponse cadastrar:jsonData :login :password];
}
+(NSString*)cadastrar:(NSData*)jsonCadastro : (NSString *)strUser : (NSString *)password{
    strUser = [strUser lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/teste.php";
    NSString *strJson = [[NSString alloc] initWithData:jsonCadastro encoding:NSUTF8StringEncoding];
    NSString *post = [NSString stringWithFormat:@"emailOrNick=%@&password=%@&json=%@", strUser, password, strJson];
    return [self doTheRequest:post andUrl:url];
}
+(NSString*)checkStart: (NSString *)email eSenha: (NSString *)password{
    email = [email lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/startCheck.php";
    
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    return [self doTheRequest:post andUrl:url];
    
}
+(NSString*)atualizaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade{
    email = [email lowercaseString];
    NSString *url = @"http://54.207.112.185/joao/atualiza.php";
    
    NSString *post = [NSString stringWithFormat:@"email=%@&sexo=%d&idade=%d&peso_atual=%f&altura=%d", email, sexo, idade, peso_atual,altura];
    return [self doTheRequest:post andUrl:url];
    
}
+(NSString*)criaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade{
    NSString *url = @"http://54.207.112.185/joao/cadastra.php";
    email = [email lowercaseString];
    NSString *post = [NSString stringWithFormat:@"email=%@&sexo=%d&idade=%d&peso_atual=%f&altura=%d", email, sexo, idade, peso_atual,altura];
    return [self doTheRequest:post andUrl:url];
    
}
+(WeatherObject *)previsaoDoTempoNaLatitude : (float)lat eLongitude:(float)lon{
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f",lat, lon ];
    NSData *jsonDados = [[NSData alloc] initWithContentsOfURL:
                         [NSURL URLWithString:url]];
    
    if(!jsonDados) {
        return nil;
    }
    
    NSError *error;
    NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                             JSONObjectWithData:jsonDados
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
    
    
    NSDictionary *main = [[NSDictionary  alloc] initWithDictionary:[jsonDadosUsuario objectForKey:@"main"]];
    NSArray *array = [jsonDadosUsuario objectForKey:@"weather"];
    
    NSNumber *tempMin = [main objectForKey:@"temp_min"];
    NSNumber *humidity = [main objectForKey:@"temp_min"];
    NSNumber *tempMax = [main objectForKey:@"temp_max"];
    NSNumber *tempAtual = [main objectForKey:@"temp"];
    float temp_min = [tempMin floatValue];
    float temp_max = [tempMax floatValue];
    float temp = [tempAtual floatValue];
    float humidade = [humidity floatValue];
    WeatherObject *novo = [[WeatherObject alloc] init];
    [novo setTempAtual:temp];
    [novo setTempMin:temp_min];
    [novo setTempMax:temp_max];
    [novo setHumidade:humidade];
    NSDictionary *weatherCondition = [array firstObject];
    NSString *str = [weatherCondition objectForKey:@"description"];
    [novo setDescricao:str];
    return novo;
    
}

//$email = $_REQUEST["nome"];
//$sexo = $_REQUEST["sexo"];
//$peso_atual = $_REQUEST["peso_atual"];
//$idade = $_REQUEST["idade"];
//$altura = $_REQUEST["altura"];
@end
