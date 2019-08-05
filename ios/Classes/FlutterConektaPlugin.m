#import "FlutterConektaPlugin.h"
#import "Conekta.h"

@implementation FlutterConektaPlugin {
    // Save a reference to the Conekta instance
    Conekta* _conekta;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_conekta"
            binaryMessenger:[registrar messenger]];
    
    Conekta* conekta = [[Conekta alloc] init];
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [conekta setDelegate:rootViewController];
    
    FlutterConektaPlugin* instance = [[FlutterConektaPlugin alloc] initWithConekta:conekta];
    [registrar addMethodCallDelegate:instance channel:channel];
}

// Custom initializer
- (instancetype)initWithConekta:(Conekta*)conekta {
    // Do the initialization
    self = [super init];
    
    // Custom initialization
    if (self) {
        _conekta = conekta;
    }
    
    return self;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"tokenizeCard" isEqualToString:call.method]) {
        NSString* publicKey = call.arguments[@"publicKey"];
        NSString* cardholderName = call.arguments[@"cardholderName"];
        NSString* cardNumber = call.arguments[@"cardNumber"];
        NSString* cvv = call.arguments[@"cvv"];
        NSString* expiryMonth = call.arguments[@"expiryMonth"];
        NSString* expiryYear = call.arguments[@"expiryYear"];
        
        [_conekta setPublicKey:publicKey];
        
        [_conekta collectDevice];
        
        Card* card = [_conekta.Card initWithNumber:cardNumber name:cardholderName cvc:cvv expMonth:expiryMonth expYear:expiryYear];
        
        Token* token = [_conekta.Token initWithCard:card];
        
        [token createWithSuccess:^(NSDictionary* data) {
            NSString* id = [data objectForKey:@"id"];
            result(id);
        } andError:^(NSError* error) {
            result([FlutterError errorWithCode:@"ERROR_UNABLE_TO_TOKENIZE" message:error.localizedDescription details:nil]);
        }];
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
