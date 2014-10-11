//
//  FriendsTableViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "EditFriendsTableViewController.h"

@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // getting the relation
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self queryFriendsRelation];
}

// Passing the friends array to the edit friends screens nsmutable array
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
        
        // getting the destination view controller in editfriends
        // Cast it to the view controller
        EditFriendsTableViewController *viewController = (EditFriendsTableViewController *)segue.destinationViewController;
        
        // setting the  property (NSMutable Array *friends) in edit Friends
        // with the array or property self.friends from the friends class
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.userSelected = [self.friends objectAtIndex:indexPath.row];
    
    NSLog(@"%@",self.userSelected);
}


#pragma mark - Helper methods

- (void) queryFriendsRelation{
    
    
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@",error, [error userInfo]);
        }else{
            
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
    
}

@end
