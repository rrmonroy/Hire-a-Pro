//
//  ForgotPasswordViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 10/28/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import <Parse/Parse.h>

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_resetPassword:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:@"iscruben@hotmail.com"];
    
/*
    // create soft wait overlay so the user knows whats going on in the background.
    [self createWaitOverlay];
    
    //the guts of the message.
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = @"youremail@email.com";
    testMsg.toEmail = @"targetemailaddress@email.com";
    testMsg.relayHost = @"smtpout.yourserver.net";
    testMsg.requiresAuth = YES;
    testMsg.login = @"yourusername@email.com";
    testMsg.pass = @"yourPassWord";
    testMsg.subject = @"This is the email subject line";
    testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    
    
    // Only do this for self-signed certs!
    // testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    //email contents
    NSString * bodyMessage = [NSString stringWithFormat:@"This is the body of the email. You can put anything in here that you want."];
    
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               bodyMessage ,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    
    [testMsg send];
 */
}



@end
