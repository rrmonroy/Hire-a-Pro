//
//  GuestSearchViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 7/27/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import "GuestSearchViewController.h"
#import "OccupationTableViewController.h"
#import "ShowGuestResultsViewController.h"


@interface GuestSearchViewController ()

@end

@implementation GuestSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self txt_tools]setDelegate:self];
    [[self txt_ocupation ]setDelegate:self];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tgr];

    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    //self.navigationController.title = @"Main";
    [self navigationController].navigationItem.leftBarButtonItem.title = @"hola";

    
   // [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

-(void)viewDidAppear:(BOOL)animated{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)listWasSelected:(OccupationTableViewController *)controller{
    
    //    [controller.navigationController popViewControllerAnimated:YES];
    NSLog(@"Value selected %@",controller.selectedRow);
    
    self.txt_ocupation.text = controller.selectedRow;
    
    [controller.navigationController popViewControllerAnimated:YES];
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"getOccupation"])
    {
        OccupationTableViewController *destViewController = (OccupationTableViewController*)segue.destinationViewController;
        destViewController.delegate = self;
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Back", returnbuttontitle) style:     UIBarButtonItemStyleBordered target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        
    }
    if ([segue.identifier isEqualToString:@"showGuestResult"])
    {
        
        ShowGuestResultsViewController  *destViewController = (ShowGuestResultsViewController*)segue.destinationViewController;
        destViewController.occupation = self.txt_ocupation.text;
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Search", returnbuttontitle) style:     UIBarButtonItemStyleBordered target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
        
    }
}

- (IBAction)btn_search:(id)sender {
    
    if (![self.txt_ocupation.text isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"showGuestResult" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Occupation is required!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
    
}
@end
