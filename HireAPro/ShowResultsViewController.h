//
//  ShowResultsViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 9/10/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface ShowResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
    @property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
    @property ( strong, nonatomic) NSManagedObjectModel *managedObjectModel;
    @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

    @property (nonatomic, retain) NSMutableArray *searchResults;
    @property (nonatomic, retain) NSString *occupation;
    @property (strong, nonatomic) IBOutlet UITableView *tableView;

    @property (nonatomic, retain) NSString *userSelected;
@end
