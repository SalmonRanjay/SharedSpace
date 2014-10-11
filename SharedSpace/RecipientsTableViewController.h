//
//  RecipientsTableViewController.h
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RecipientsTableViewController : UITableViewController

@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *date;


@property (nonatomic, strong) PFRelation *friendsRelation;

@property (nonatomic, strong) NSArray *friends;

@property (nonatomic,strong) PFUser *userSelected;

@property (nonatomic,strong) NSMutableArray *recipients;

- (void) queryFriendsRelation;

- (IBAction)send:(id)sender;

- (IBAction)cancel:(id)sender;


@end
