//
//  EditFriendsTableViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "EditFriendsTableViewController.h"

@interface EditFriendsTableViewController ()

@end

@implementation EditFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // declare class variable array in header called *allUsers
    
    // query all users in the parse database
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"]; // order in alphabetical order by user name
    // run query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // Error display errory message
            
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }else{
            // else success
            // storing the users returned into the NSArray we declared in our class
            self.allUsers = objects;
            
            
            // Due to asynchoneous request
            // let the tableview know that data is ready
            // by sending the following message
            [self.tableView reloadData];
            
            
            
        }
    }];
    
    // setting current user
    self.currentUser = [PFUser currentUser];
    
    // setting the friends relation
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"EditFCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // return the array of users into a PFuser object
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}

#pragma  mark - Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // allow the selected field to disappear
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    // Adding check mark to add users
    
    // get reference to the current table view cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    // setting the friends relation object
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    
    if ([self isFriend:user]) {
        // remove them
        // 1. remove checkmark
        cell.accessoryType = UITableViewCellAccessoryNone;
        
         NSLog(@"Not Friend: %@", user.username);
        
        // 2. remove from array of friends
        for (PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }
        
        // 3. remove from the backend
        [friendsRelation removeObject:user];
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        // adding user back to array
        [self.friends addObject:user];
        
        // adding the user relation
        [friendsRelation addObject:user];
        
        NSLog(@"Friends: %@", self.friends);
        
    }
    // saving the relation to the backend
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Helper Methods

- (BOOL) isFriend:(PFUser *)user{
    
    // search through the list of friends received
    // and check if the object id of the friend selected matches
    // the object id of the friends in the friends list
    for (PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            NSLog(@"Friends are: %@",self.friends);
            
            return YES;
        }
    }
    return NO;
}

@end
