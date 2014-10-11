//
//  RecipientsTableViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "RecipientsTableViewController.h"

@interface RecipientsTableViewController ()

@end

@implementation RecipientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recipients = [[NSMutableArray alloc] init];
    
    // getting the relation
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self queryFriendsRelation];
}

// Passing the friends array to the edit friends screens nsmutable array
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
//        
//        // getting the destination view controller in editfriends
//        // Cast it to the view controller
//        EditFriendsTableViewController *viewController = (EditFriendsTableViewController *)segue.destinationViewController;
//        
//        // setting the  property (NSMutable Array *friends) in edit Friends
//        // with the array or property self.friends from the friends class
//        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
//    }
//    
    
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
    
     [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//    self.userSelected = [self.friends objectAtIndex:indexPath.row];
//    
//    NSLog(@"%@",self.userSelected);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    // toggle checkmark
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        // adding recipient to the array
        [self.recipients addObject:user.objectId];
        
    }else{
        
        // unchecking person and deleting hem
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipients removeObject:user.objectId];
    }

    
    
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


- (void) dissmissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)send:(id)sender {
    
       // save object to parse
     PFObject *pfrequest = [PFObject objectWithClassName:@"Requests"];
    
    NSLog(@"Recipients: %@", self.recipients);
     
     pfrequest[@"newRequest"] = self.event;
     pfrequest[@"newCost"] = self.cost;
    pfrequest[@"newDescription"] = self.desc;
    pfrequest[@"sender"] = [PFUser currentUser];
    pfrequest[@"sendeName"] = [[PFUser currentUser] username];
    pfrequest[@"recipients"] = self.recipients;
    pfrequest[@"newDate"] = self.date;
     
     [pfrequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
         //
         NSLog(@"Er: %@", error);
         if (error) {
             NSLog(@"%@ %@",error,[error userInfo]);
         }
     }];
     
     [self dissmissSelf];
    [self.tabBarController setSelectedIndex:0];
    
     
    

    
}

- (IBAction)cancel:(id)sender {
    
    [self dissmissSelf];
}

@end
