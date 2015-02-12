//
//  BAHVimeoOAuthViewController.h
//  BAHVimeoOAuth
//
//  Created by BHughes on 1/31/15.
//  Copyright (c) 2015 BHughes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface BAHVimeoOAuthViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *oAuthWebView;

@property (nonatomic, strong)NSString *vimeoAuthorizationHeader;

@property (nonatomic, strong)NSString *uriCallBack;

@property (nonatomic, strong)NSString *state;

@end
