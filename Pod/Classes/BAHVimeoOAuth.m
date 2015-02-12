//
//  BAHVimeoOAuth.m
//  BAHVimeoOAuth
//
//  Created by BHughes on 1/31/15.
//  Copyright (c) 2015 BHughes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAHVimeoOAuth.h"


@interface BAHVimeoOAuth ()

@end

@implementation BAHVimeoOAuth : NSObject

static NSString *vimeoClientID = @"b2c5f0c7e7672375f619868373a756293a89569a";
static NSString *vimeoAuthURL = @"https://api.vimeo.com/oauth/authorize";
static NSString *appURLCallBack = @"BladerFeed://";
 

+ (void)authenticateWithVimeoUsingVimeoClientID:(NSString*)vimeoClientID vimeoAuthorizationHeader:(NSString*)vimeoAuthorizationHeader scope:(NSString*)scope state:(NSString*)state appURLCallBack:(NSString*)appURLCallBack sender:(id)sender;{
    
    if (!scope) {
        scope = @"public";
    }
    
    NSString *authenticateURLString = [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&state=%@&scope=%@&redirect_uri=%@", vimeoAuthURL, vimeoClientID, state, scope, appURLCallBack];
    
    NSLog(@"authenicatestring %@", authenticateURLString);
    BAHVimeoOAuthViewController *OAuthController = [[BAHVimeoOAuthViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:OAuthController];
    
    [sender presentViewController:navController animated:YES completion:^{
        OAuthController.vimeoAuthorizationHeader = vimeoAuthorizationHeader;
        OAuthController.uriCallBack = appURLCallBack;
        OAuthController.state = state;
        [OAuthController.oAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]]];
        
    }];
}

@end