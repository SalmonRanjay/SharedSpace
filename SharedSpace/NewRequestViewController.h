//
//  NewRequestViewController.h
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTableViewController.h"
#import <Parse/Parse.h>

@interface NewRequestViewController : UIViewController


- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *enterRequestField;
@property (weak, nonatomic) IBOutlet UITextField *enterCostField;

- (IBAction)addRequestButton:(id)sender;

@end
