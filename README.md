# BAHVimeoOAuth

[![CI Status](http://img.shields.io/travis/BHughes3388/BAHVimeoOAuth.svg?style=flat)](https://travis-ci.org/BHughes3388/BAHVimeoOAuth)
[![Version](https://img.shields.io/cocoapods/v/BAHVimeoOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHVimeoOAuth)
[![License](https://img.shields.io/cocoapods/l/BAHVimeoOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHVimeoOAuth)
[![Platform](https://img.shields.io/cocoapods/p/BAHVimeoOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHVimeoOAuth)

## Preview

![](http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/6bffa370-627d-43b7-8128-136d11700b27_zpsgdk1fbjo.png) ![](http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/VimeoOAuth_zpsl69a72mp.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BAHVimeoOAuth is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BAHVimeoOAuth"

## Setup

Import
```Objective-C
#import "BAHVimeoOAuth.h"
```

Where ever you would like your user to login to vimeo and retrieve a token 
```Objective-C
BAHVimeoOAuth *vimeoOAuth = [[BAHVimeoOAuth alloc]init];

[vimeoOAuth authenticateWithVimeoUsingVimeoClientID:vimeoClientID
                           vimeoAuthorizationHeader:vimeoAuthorizationHeader
                                              scope:nil
                                              state:state
                                    appURLCallBack:appURLCallBack
                                    viewController:self
                                                  :^(BOOL success, NSString *vimeoToken) {

                                                    if (success) {

                                                        //Optional saving the returned token to NSUserDefaults
                                                        [[NSUserDefaults standardUserDefaults] setObject:vimeoToken forKey:@"vimeo_token"];
                                                        [[NSUserDefaults standardUserDefaults] synchronize];

                                                        //Do what ever you need to do with the returned token
                                                        //[self requestVideosFromVimeo];

                                                        }

                                                    }];
```

## Author

BHughes3388, BHughes3388@gmail.com

## License

BAHVimeoOAuth is available under the MIT license. See the LICENSE file for more info.

