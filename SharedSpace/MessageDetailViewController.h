//
//  MessageDetailViewController.h
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MessageDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *eventVariableField;

@property (weak, nonatomic) IBOutlet UILabel *costVariableLabel;


@property (weak, nonatomic) IBOutlet UILabel *descVariableLabel;


@property (weak, nonatomic) IBOutlet UILabel *dateVariableLabel;
@property (nonatomic, strong) PFObject *object;

- (IBAction)accept:(id)sender;


- (IBAction)deny:(id)sender;

@end
