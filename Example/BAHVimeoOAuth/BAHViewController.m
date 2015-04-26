//
//  BAHViewController.m
//  BAHVimeoOAuth
//
//  Created by BHughes on 4/25/15.
//  Copyright (c) 2015 BHughes3388. All rights reserved.
//

#import "BAHViewController.h"

@interface BAHViewController ()

@end

@implementation BAHViewController{
    NSMutableArray *videoNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"Vimeo OAuth Demo"];
    [titleLabel setTextColor:[UIColor colorWithRed:26/255.0f green:183/255.0f blue:234/255.0f alpha:1.0f]];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:26.0f]];
    [titleLabel sizeToFit];
    [self.navigationItem setTitleView:titleLabel];
    
    [self.requestButton addTarget:self action:@selector(requestVimeoToken) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)requestVimeoToken{
    
    //set each of these to the credientials in your Vimeo App
    static NSString *vimeoClientID = @"fb9dfd84606d7e1f05620ab1a5cc7d6e37242a46";
    //Redirect URI doesn't actually have to be set in info.plist, just has to match what it is in your Vimeo App
    static NSString *appURLCallBack = @"BAHVimeoOAuth://";
    static NSString *vimeoAuthorizationHeader = @"Basic ZmI5ZGZkODQ2MDZkN2UxZjA1NjIwYWIxYTVjYzdkNmUzNzI0MmE0Njo4MTJiYzMxNjcwZTk4MTc5MTU1NThmYTMzNDliOWQwMTFmZDBlNGZi";
    static NSString *state = @"BAHVimeoOAuth";
    //if scope is set to nil it was automatically be set to default
    //static NSString *scope = @"";
    
    BAHVimeoOAuth *vimeoOAuth = [[BAHVimeoOAuth alloc]init];
    
    [vimeoOAuth authenticateWithVimeoUsingVimeoClientID:vimeoClientID
                               vimeoAuthorizationHeader:vimeoAuthorizationHeader
                                                  scope:nil
                                                  state:state
                                         appURLCallBack:appURLCallBack
                                         viewController:self
                                                       :^(BOOL success, NSString *vimeoToken) {
                                                           
                                                           
                                                           if (success) {
                                                               
                                                               [[NSUserDefaults standardUserDefaults] setObject:vimeoToken forKey:@"vimeo_token"];
                                                               [[NSUserDefaults standardUserDefaults] synchronize];
                                                               
                                                               [self performSegueWithIdentifier:@"Videos" sender:self];
                                                           }
                                                
                                                       }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
