//
//  NewRequestViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "NewRequestViewController.h"
#import "RecipientsTableViewController.h"

@interface NewRequestViewController ()

@end

@implementation NewRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    
    
    if ([self.request length] == 0 || [self.cost length] == 0 || [self.desc length] == 0 || [self.date length] == 0){
        
        return NO;
    }else{
        
        return YES;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual:@"selectRecipients"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        
        RecipientsTableViewController *recipientsController = (RecipientsTableViewController*)navController.visibleViewController;
        
       
            recipientsController.event =[[NSString alloc] initWithString:self.request];
            recipientsController.cost = [[NSString alloc] initWithString:self.cost];
            recipientsController.desc = [[NSString alloc] initWithString:self.desc];
            recipientsController.date = [[NSString alloc] initWithString:self.date];
    }
    
    
}


// creating helper method to dismiss view controller
- (void) dissmissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) reset{
    
    self.enterRequestField.text = @"";
     self.enterDate.text = @"";
     self.enterDescriptionField.text = @"";
     self.enterCostField.text = @"";
    
}

- (IBAction)cancel:(id)sender {
    [self dissmissSelf];
}
- (IBAction)addRequestButton:(id)sender {
    
    self.request = self.enterRequestField.text;
    self.cost = self.enterCostField.text;
    self.desc = self.enterDescriptionField.text;
    self.date = self.enterDate.text;
    
    NSLog(@"%@", self.request);
    
    if ([self.request length] == 0 || [self.cost length] == 0 || [self.desc length] == 0 || [self.date length] == 0) {
        // display ui alert view
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Make sure all fields are entered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
    
        /*    // save object to parse
        PFObject *pfrequest = [PFObject objectWithClassName:@"Requests"];
        
        pfrequest[@"newRequest"] = request;
        pfrequest[@"newCost"] = cost;
        
        [pfrequest saveInBackground];
        
        [self dissmissSelf];
         
         */
        
        [self reset];
        
    }
}
@end
