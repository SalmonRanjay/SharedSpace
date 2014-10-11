//
//  RequestTableViewController.h
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RequestTableViewController : PFQueryTableViewController

@property (nonatomic,strong) NSArray *messages;

@property (nonatomic, strong) NSMutableArray *requestArray;
- (IBAction)logout:(id)sender;

@end
