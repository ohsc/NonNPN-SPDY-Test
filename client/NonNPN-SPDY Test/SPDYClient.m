//
//  SPDYClient.m
//  NonNPN-SPDY Test
//
//  Created by OHSC on 14-2-25.
//  Copyright (c) 2014年 imchao. All rights reserved.
//

#import "SPDYClient.h"
#import "SPDYProtocol.h"
#import "SPDYTLSTrustEvaluator.h"
#import "SPDYLogger.h"

@interface SPDYClient () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, SPDYTLSTrustEvaluator>
@end

@implementation SPDYClient
- (instancetype)init {
    self = [super init];
    if (self) {
        SPDYConfiguration *configuration = [[SPDYConfiguration alloc] init];
        NSMutableDictionary *tlsSettings = [NSMutableDictionary dictionary];
        [tlsSettings setObject:(NSString *)kCFBooleanFalse forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
        [configuration setValue:tlsSettings forKey:@"tlsSettings"];
        
        [SPDYURLConnectionProtocol setConfiguration:configuration];
        [SPDYURLConnectionProtocol setTLSTrustEvaluator:self];
        [SPDYURLConnectionProtocol registerOrigin:@"https://127.0.0.1:3232"];
    }
    
    return self;
}

- (void)sendMessage:(NSString *)payload {
    NSData *pubData=[payload dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://127.0.0.1:3232/"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:pubData];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"request failed: %@", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"requested.");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *payloadString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", payloadString);
}

- (BOOL)evaluateServerTrust:(SecTrustRef)trust forHost:(NSString *)host {
    return YES;
}

@end
