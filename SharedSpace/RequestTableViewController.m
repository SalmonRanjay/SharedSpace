//
//  RequestTableViewController.m
//  SharedSpace
//
//  Created by Ranjay Salmon on 10/11/14.
//  Copyright (c) 2014 Ranjay Salmon. All rights reserved.
//

#import "RequestTableViewController.h"


@interface RequestTableViewController ()

@end

@implementation RequestTableViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.parseClassName = @"Requests";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parseClassName = @"Requests";
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // let them enjoy the app
    }else{
        // show to login screen
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    
    }
}

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    PFQuery *messaegQuery = [PFQuery queryWithClassName:@"Requests"];
//    [messaegQuery whereKey:@"recipients" containsAllObjectsInArray:@[[PFUser currentUser].objectId]];
//    [messaegQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        if (!error) {
//            // you have all the messages
//            self.messages = objects;
//            NSLog(@"Messages: %@", self.messages);
//        }else{
//            
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"recipients" containsAllObjectsInArray:@[[PFUser currentUser].objectId]];

    return query;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return self.messages.count;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"Cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = object[@"senderName"];
    cell.detailTextLabel.text = object[@"newDescription"];
    
    return cell;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}


- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
@end
