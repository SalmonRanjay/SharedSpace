//
//  MessageDetailViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eventVariableField.text = _object[@"newRequest"];
    _costVariableLabel.text = _object[@"newCost"];
    _descVariableLabel.text = _object[@"newDescription"];
    _dateVariableLabel.text = _object[@"newDate"];
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

- (IBAction)accept:(id)sender {
    
    
    
    
   

    PFObject *pfrequest = [PFObject objectWithClassName:@"Requests"];
    
    
    pfrequest[@"newRequest"] = @"";
    pfrequest[@"newCost"] = @"";
    pfrequest[@"newDescription"] = @"";
    
    pfrequest[@"recipients"] = @[((PFObject*)_object[@"sender"]).objectId];
    pfrequest[@"response"] = @"Yes";
    
    pfrequest[@"sender"] = [PFUser currentUser];
    pfrequest[@"sendeName"] = [[PFUser currentUser] username];
   
    pfrequest[@"newDate"] =@"";
    
    [pfrequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //
        NSLog(@"Er: %@", error);
        if (error) {
            NSLog(@"%@ %@",error,[error userInfo]);
        }
    }];
    
        [self.tabBarController setSelectedIndex:0];
    

}

- (IBAction)deny:(id)sender {
}


@end
