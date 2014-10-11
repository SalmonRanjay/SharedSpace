//
//  NewRequestViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "NewRequestViewController.h"

@interface NewRequestViewController ()

@end

@implementation NewRequestViewController

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

// creating helper method to dismiss view controller
- (void) dissmissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel:(id)sender {
    [self dissmissSelf];
}
- (IBAction)addRequestButton:(id)sender {
    
    // check if empty fields
    NSString *request = self.enterRequestField.text;
    NSString *cost = self.enterCostField.text;
    
    if ([request length] == 0 || [cost length] == 0) {
        // display ui alert view
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Make sure all fields are entered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
    
            // save object to parse
        PFObject *pfrequest = [PFObject objectWithClassName:@"Requests"];
        
        pfrequest[@"newRequest"] = request;
        pfrequest[@"newCost"] = cost;
        
        [pfrequest saveInBackground];
        
        [self dissmissSelf];
        
    }
}
@end
