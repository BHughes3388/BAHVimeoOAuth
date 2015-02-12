//
//  BAHVimeoOAuth.h
//  BAHVimeoOAuth
//
//  Created by BHughes on 1/31/15.
//  Copyright (c) 2015 BHughes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BAHVimeoOAuthViewController.h"


//! Project version number for BAHVimeoOAuth.
//FOUNDATION_EXPORT double BAHVimeoOAuthVersionNumber;

//! Project version string for BAHVimeoOAuth.
//FOUNDATION_EXPORT const unsigned char BAHVimeoOAuthVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <BAHVimeoOAuth/PublicHeader.h>


@interface BAHVimeoOAuth : NSObject


+ (void)authenticateWithVimeoUsingVimeoClientID:(NSString*)vimeoClientID vimeoAuthorizationHeader:(NSString*)vimeoAuthorizationHeader scope:(NSString*)scope state:(NSString*)state appURLCallBack:(NSString*)appURLCallBack sender:(id)sender;


@end
