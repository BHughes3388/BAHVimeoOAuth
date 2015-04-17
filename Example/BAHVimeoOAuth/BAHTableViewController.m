//
//  BAHTableViewController.m
//  BAHVimeoOAuth
//
//  Created by BHughes on 2/12/15.
//  Copyright (c) 2015 BHughes3388. All rights reserved.
//

#import "BAHTableViewController.h"

@interface BAHTableViewController (){
    NSMutableArray *videoNames;
}

@end

@implementation BAHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                                                         
                                                         videoNames = [[NSMutableArray alloc]init];
                                                         
                                                         [self requestVideosFromVimeo];
                                                     }

                                                     
                                                     
    
}];
    
}

- (void)requestVideosFromVimeo{
    
    //this is just a sample on how to get data from Vimeo usint AFNetworking
    
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"vimeo_token"];
    
    NSLog(@"tokenstring %@", tokenString);
    
    NSString *newURL = [NSString stringWithFormat:@"https://api.vimeo.com/me/videos?access_token=%@",tokenString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:newURL]];
    
    [request setHTTPMethod:@"GET"];
    
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        NSArray *videoData = [json objectForKey:@"data"];
        
        for (NSDictionary *video in videoData) {
            
            if ([video objectForKey:@"name"] != nil) {
                
                [videoNames addObject:[video objectForKey:@"name"]];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    [[NSOperationQueue mainQueue] addOperation:op];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return videoNames.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Vimeo Videos";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell.textLabel setText:videoNames[indexPath.row]];
    
    return cell;
}


@end
