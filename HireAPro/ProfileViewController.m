//
//  ProfileViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 7/28/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "Person.h"

@interface ProfileViewController ()
    -(void)showErrorView:(NSString *)errorMsg;
@end

@implementation ProfileViewController

@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
    
    
    [self.scrollView setScrollEnabled:YES ];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,788)];

    
    user = app.currentUser;
    
    
    PFQuery *query3 = [PFUser query];
    [query3 whereKey:@"username" equalTo:user]; // find all the women

    NSArray *users = [query3 findObjects];
    Person *person = [Person new];

    
    
    PFFile *image ; //= (PFFile *)[wallObject objectForKey:KEY_IMAGE];
    
    for (PFUser *resutlUsers in users){
        NSLog(@"First name %@",[resutlUsers objectForKey:@"FirstName"]);

        person.userid = [resutlUsers objectForKey:@"ObjectId"];
        
        person.username = [resutlUsers objectForKey:@"username"];
        person.firstname = [resutlUsers objectForKey:@"FirstName"];
        
        
        person.email = [resutlUsers objectForKey:@"email"];
        person.lastname = [resutlUsers objectForKey:@"LastName"];
        person.address = [resutlUsers objectForKey:@"Address"];
        person.city = [resutlUsers objectForKey:@"City"];
        person.state = [resutlUsers objectForKey:@"State"];
        person.zip = [resutlUsers objectForKey:@"Zip"];
        person.country = [resutlUsers objectForKey:@"Country"];
        person.phone = [resutlUsers objectForKey:@"Phone"];
        person.website = [resutlUsers objectForKey:@"Website"];
        person.facebookid = [resutlUsers objectForKey:@"FacebookId"];
        person.profileid = [resutlUsers objectForKey:@"ProfileId"];
        person.profilestatus = [resutlUsers objectForKey:@"ProfileStatus"];
        person.status = [resutlUsers objectForKey:@"Status"];
        person.comments = [resutlUsers objectForKey:@"Comments"];
        //ProfPicture
        
        image = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
    }

    
    self.txt_username.text = person.firstname;
    self.txt_lastname.text = person.lastname;
    self.txt_address.text = person.address;
    self.txt_city.text = person.city;
    self.txt_state.text = person.state;
    self.txt_zip.text = person.zip;
    self.txt_country.text = person.country;
// self.txt_email.text = person.email;
    self.txt_phone.text = person.phone;
    

    [[self txt_username ]setDelegate:self];
    [[self txt_lastname ]setDelegate:self];
    [[self txt_address ]setDelegate:self];
    [[self txt_city ]setDelegate:self];
    [[self txt_state ]setDelegate:self];
    [[self txt_zip ]setDelegate:self];
    [[self txt_country ]setDelegate:self];
//    [[self txt_email ]setDelegate:self];
    [[self txt_phone ]setDelegate:self];
    
    //Show Prof Picture
    
    //Add the image
    
    
    NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,self.profile_pic.frame.size.width  );
    
    
    
    //UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];

    self.profile_pic.image = [UIImage imageWithData:image.getData];
   
    /*
    if ([UIImage imageWithData:image.getData].size.width>[UIImage imageWithData:image.getData].size.height) {
        
        int yy=0;
        int xx = [UIImage imageWithData:image.getData].size.width/300;
        
        yy=[UIImage imageWithData:image.getData].size.height/xx;
        if (yy>200) {
            
            yy=0;
            xx = [UIImage imageWithData:image.getData].size.height/200;
            
            yy=[UIImage imageWithData:image.getData].size.width/xx;
            
            
            userImage.frame = CGRectMake((300-yy)/2, 0, yy, 200);
            
        }else{
            userImage.frame = CGRectMake(0, 0, 300, yy);
        }
    }else{
        int yy=0;
        int xx = [UIImage imageWithData:image.getData].size.height/200;
        
        yy=[UIImage imageWithData:image.getData].size.width/xx;
        
        userImage.frame = CGRectMake((300-yy)/2, 0, yy, 200);
    }
    
    */
    
    
    
    self.profile_pic.userInteractionEnabled = YES;
    self.profile_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.profile_pic.layer.cornerRadius = (self.profile_pic.frame.size.width / 2);
    self.profile_pic.layer.borderWidth = 2.0f;
    self.profile_pic.layer.borderColor = [UIColor grayColor].CGColor;
    self.profile_pic.clipsToBounds = YES;
    
    
    
    
    
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tgr];
    

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@" aaa %ld",(long)textField.tag);
    if(textField.tag == 8 ){
        [textField resignFirstResponder];
        return YES;
    }
    else{

        NSInteger nextTag = textField.tag + 1;
        if (nextTag==8) {
            [self.txt_phone becomeFirstResponder];
            
        }else{
    NSLog(@" else %ld",(long)textField.tag);
            
            UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
            if (nextResponder) {
                // Found next responder, so set it.
                [nextResponder becomeFirstResponder];
            } else {
                // Not found, so remove keyboard.
                [textField resignFirstResponder];
            }
        }
        
        return NO; // We do not want UITextField to insert line-breaks.
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"shouldChangeTextInRange");
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
        [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if(textField.tag == 1 ){
        [self.scrollView setContentOffset:CGPointMake(0, -50) animated:YES];
        
    }else if (textField.tag == 2){
        [self.scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }else if (textField.tag == 3){
        [self.scrollView setContentOffset:CGPointMake(0, -10) animated:YES];
    }else if (textField.tag == 4){
        [self.scrollView setContentOffset:CGPointMake(0, 40) animated:YES];
    }else if (textField.tag == 5){
        [self.scrollView setContentOffset:CGPointMake(0, 70) animated:YES];
    }else if (textField.tag == 6){
        [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField.tag == 7){
        [self.scrollView setContentOffset:CGPointMake(0, 130) animated:YES];
    }else if (textField.tag == 8){
        [self.scrollView setContentOffset:CGPointMake(0, 160) animated:YES];
        
    }
    
    
    
   
}

- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
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

- (IBAction)Save:(id)sender {
    
//    PFQuery *query = [PFQuery queryWithClassName:@"UserStats"];
//    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    

    
    // --------------------
    // --------------------
    
    
    //Upload a new picture

    
    NSLog(@"MyImage width %f height %f size in bytes:%i",self.profile_pic.image.size.width,self.profile_pic.image.size.height,[UIImagePNGRepresentation(self.profile_pic.image) length]);
    
    NSData *pictureData;
    if([UIImagePNGRepresentation(self.profile_pic.image) length]> 10485760){
        
        UIImage *image = self.profile_pic.image;
        UIImage *tempImage = nil;
        
        
        if (self.profile_pic.image.size.width>self.profile_pic.image.size.height) {
            int yy=0;
            int xx = self.profile_pic.image.size.width/1000;
            
            yy=self.profile_pic.image.size.height/xx;
            
            CGSize targetSize = CGSizeMake(1000,yy);
            UIGraphicsBeginImageContext(targetSize);
            
            CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
            thumbnailRect.origin = CGPointMake(0.0,0.0);
            thumbnailRect.size.width  = targetSize.width;
            thumbnailRect.size.height = targetSize.height;
            
            [image drawInRect:thumbnailRect];
            
            tempImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            pictureData = UIImagePNGRepresentation(tempImage);
        }else{
            int yy=0;
            int xx = self.profile_pic.image.size.height/1000;
            
            yy=self.profile_pic.image.size.width/xx;
            
            CGSize targetSize = CGSizeMake(yy,1000);
            UIGraphicsBeginImageContext(targetSize);
            
            CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
            thumbnailRect.origin = CGPointMake(0.0,0.0);
            thumbnailRect.size.width  = targetSize.width;
            thumbnailRect.size.height = targetSize.height;
            
            [image drawInRect:thumbnailRect];
            
            tempImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            pictureData = UIImagePNGRepresentation(tempImage);
            
        }
        
        
        NSLog(@"after resiing width %f height %f size in bytes:%i",tempImage.size.width,tempImage.size.height,[UIImagePNGRepresentation(tempImage) length]);
        
        
    }else{
        pictureData = UIImagePNGRepresentation(self.profile_pic.image);
    }
    
    
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    
 
    
    
    
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //Add the image to the object, and add the comments, the user, and the geolocation (fake)
            //PFObject *imageObject = [PFObject objectWithClassName:WALL_OBJECT];
            //[imageObject setObject:file forKey:KEY_IMAGE];

            //[imageObject setObject:[PFUser currentUser].username forKey:KEY_USER];
            //[imageObject setObject:self.commentTextField.text forKey:KEY_COMMENT];
            
            //PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:52 longitude:-4];
            //[imageObject setObject:point forKey:KEY_GEOLOC];
            
            
            
            PFQuery *query = [PFUser query];
            [query whereKey:@"username" equalTo:user]; // find all the women
            
            [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
                if (!error) {
                    NSLog(@"Found UserStats");
                    
                    [userStats setObject:self.txt_username.text forKey:@"FirstName"];
                    [userStats setObject:self.txt_lastname.text forKey:@"LastName"];
                    [userStats setObject:self.txt_address.text forKey:@"Address"];
                    [userStats setObject:self.txt_city.text forKey:@"City"];
                    [userStats setObject:self.txt_state.text forKey:@"State"];
                    [userStats setObject:self.txt_zip.text forKey:@"Zip"];
                    [userStats setObject:self.txt_country.text forKey:@"Country"];
                    [userStats setObject:self.txt_phone.text forKey:@"Phone"];
                    
                    //            [userStats setObject:self.txt_email.text forKey:@"email"];
                    
                    [userStats setObject:file forKey:@"ProfPicture"];
                    
                    // Save
                   // [userStats saveInBackground];
                    
                    
                    [userStats saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        
                        if (succeeded){
                            //Go back to the wall
                            //[self.navigationController popViewControllerAnimated:YES];
                            
                            
//                            [self showErrorView:@"Profile has been updated"];
                            
                            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Profile" message:@"Profile has been updated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            [errorAlertView show];
                            
                                [self.navigationController popViewControllerAnimated:YES];
                        }
                        else{
                            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                            [self showErrorView:errorString];
                        }
                    }];
                    
                    
                    
                    
                } else {
                    // Did not find any UserStats for the current user
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    [self showErrorView:errorString];
                    
                    NSLog(@"Error --->: %@", error);
                }
            }];
            
            
            
            
            
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
        
        
    } progressBlock:^(int percentDone) {
        
    }];
    
    
    
    
    
}

-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}



- (IBAction)change_profilePic:(id)sender {
        [self showPicOptions:sender];
}
- (void) showPicOptions:(UIButton *)sender {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", @"Take Photo action")
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action)
                                      {
                                          UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                          picker.delegate = self;
                                          picker.allowsEditing = YES;
                                          picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                          
                                          [self presentViewController:picker animated:YES completion:NULL];
                                          
                                      }];
    
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Photo Library", @"Photo Library action")
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action)
                                         {
                                             UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                             picker.delegate = self;
                                             picker.allowsEditing = YES;
                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                             
                                             [self presentViewController:picker animated:YES completion:NULL];
                                             
                                         }];
    
    UIAlertAction *customIconsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Custom Icons", @"Custom Icons action")
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            NSLog(@"Archive action");
                                        }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoLibraryAction];
    [alertController addAction:customIconsAction];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - Image Picker Controller delegate methods
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];

    
    //UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(((cell.frame.size.width-70)/2),20, 70, 70)];
//    imv.image=[UIImage imageNamed:imgName];
    
    
    // imv.frame = CGRectMake(104, 106, 133, 133);
    
    // circle
    
    self.profile_pic.image = chosenImage;
    
    self.profile_pic.userInteractionEnabled = YES;
    self.profile_pic.contentMode = UIViewContentModeScaleAspectFit;
    
    self.profile_pic.layer.cornerRadius = (self.profile_pic.frame.size.width / 2);
    self.profile_pic.layer.borderWidth = 2.0f;
    self.profile_pic.layer.borderColor = [UIColor grayColor].CGColor;
    self.profile_pic.clipsToBounds = YES;
    
    //        imv.backgroundColor = [UIColor blueColor];
    

    
    
        //
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)btn_cancel:(id)sender {
    NSLog(@"1");
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
