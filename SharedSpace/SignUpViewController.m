//
//  SignUpViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)signup:(id)sender {
    
    NSString *username = [[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *group = [self.groupField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [password length] == 0 || [group length] == 0) {
        
        // display error dialogue
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Please make sure you enter a username, password and group" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertview show];
        
    }else{
        
        
        // signup user to parse
        PFUser *user = [PFUser user];
        
        user.username = username;
        user.password = password;
        
        user[@"group"] = group;
        
        
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            // save the users data
            if (!error) {
                // let the user use the app
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"Current user: %@", user.username);
                
            }else{
                
                // else display a sign up error
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertview show];
                
            }

        }];
    
    }
         
        
}
@end
