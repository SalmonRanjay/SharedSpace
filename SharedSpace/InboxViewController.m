//
//  InboxViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "InboxViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    
    NSString *username = [[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   
    
    if ([username length] == 0 || [password length] == 0 ) {
        
        // display error dialogue
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Please make sure you enter a username, password and group" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertview show];
        
    }else{
        
      // login in user
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            //
            if (!error) {
                // Login the user
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
            
                // display error message
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertview show];
            
            }
        }];
        
    }

    
    
}
@end
