//
//  BAHVimeoOAuthViewController.m
//  BAHVimeoOAuth
//
//  Created by BHughes on 1/31/15.
//  Copyright (c) 2015 BHughes. All rights reserved.
//

#import "BAHVimeoOAuthViewController.h"

@interface BAHVimeoOAuthViewController ()

@end

@implementation BAHVimeoOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:26.0f/225 green:183.0f/225 blue:234.0f/225 alpha:1.0f]];
    
    self.oAuthWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.oAuthWebView setDelegate:self];
    
    [self.view addSubview:self.oAuthWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *URLString = [[request URL] absoluteString];
    
    if ([URLString rangeOfString:@"state="].location != NSNotFound) {
        static NSString *vimeoTokenURL = @"https://api.vimeo.com/oauth/access_token";
        
        NSArray *reply= [URLString componentsSeparatedByString:@"="];
        
        NSString *code = reply.lastObject;
        NSString *state = [[reply[1] componentsSeparatedByString:@"&"] firstObject] ;
        
        if ([state isEqualToString:self.state]) {
            
            NSString *post = [NSString stringWithFormat:@"grant_type=authorization_code&redirect_uri=%@&code=%@", self.uriCallBack, code];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:vimeoTokenURL]];
            
            [request setValue:self.vimeoAuthorizationHeader forHTTPHeaderField:@"Authorization"];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                
                NSString *token = [json objectForKey:@"access_token"];
                
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"vimeo_token"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];

                [self dismissViewControllerAnimated:YES completion:nil];
                
                
            }];
            
        }
        
    }
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
