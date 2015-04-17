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

static NSString *vimeoTokenURL = @"https://api.vimeo.com/oauth/access_token";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:26.0f/255 green:183.0f/255 blue:234.0f/255 alpha:1.0f]];
    
    // Vimeo logo for navigationbar
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
    [logo setTintColor:[UIColor whiteColor]];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [logo setImage:[[UIImage imageNamed:@"vimeo_logo.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [self.navigationItem setTitleView:logo];
    
    // Setup webview for user signin and confirm use of your app
    self.oAuthWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.oAuthWebView setDelegate:self];
    self.oAuthWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.oAuthWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *URLString = [[request URL] absoluteString];
    
    // Here we check the request for the presence of the "state=" to know we have the correct request
    if ([URLString rangeOfString:@"state="].location != NSNotFound) {
        
        NSArray *reply= [URLString componentsSeparatedByString:@"="];
    
        NSString *code = reply.lastObject;
        NSString *state = [[reply[1] componentsSeparatedByString:@"&"] firstObject] ;
        
        
        //we check to make sure the state is equal to the state we specified.
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
                
                if (token) {
                    
                    BAHVimeoOAuth *vimeoOAuth = (BAHVimeoOAuth *)self.vimeoSender;
                    vimeoOAuth.completelion(YES, token);
                    [self dismissViewControllerAnimated:YES completion:nil];

                }else{
                    //TODO:Handle Error
                }
                
            }];
        
        }
        
    }
    
    return YES;
}

@end
