//
//  FriendsTableViewController.h
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsTableViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;

@property (nonatomic, strong) NSArray *friends;

@property (nonatomic,strong) PFUser *userSelected;

- (void) queryFriendsRelation;


@end
