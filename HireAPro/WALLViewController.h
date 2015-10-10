//
//  WALLViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 10/7/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"
@interface WALLViewController : PFQueryTableViewController
    @property (strong, nonatomic) NSString *user;
- (IBAction)btn_like:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
