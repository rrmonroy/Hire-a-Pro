//
//  TPUploadImageViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//
/*
 Errors
 
 PFFile cannot be larger than 10485760 bytes
 
 */
#import "UploadImageViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"



@interface UploadImageViewController ()

-(void)showErrorView:(NSString *)errorMsg;

@end

@implementation UploadImageViewController

@synthesize imgToUpload = _imgToUpload;
@synthesize username = _username;
@synthesize commentTextField = _commentTextField;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.imgToUpload = nil;
    self.username = nil;
    self.commentTextField = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IB Actions

-(IBAction)selectPicturePressed:(id)sender
{
    [self showPicOptions:sender];
    /*
    NSLog(@"selectPicturePressed");
    //Open a UIImagePickerController to select the picture
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentModalViewController:imgPicker animated:YES];
     */
}

//}
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
                                          //picker.allowsEditing = YES;
                                          picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                                          
                                          [self presentViewController:picker animated:YES completion:NULL];
                                          
                                      }];
    
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Photo Library", @"Photo Library action")
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action)
                                         {
                                             /*
                                             UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                             picker.delegate = self;
                                             picker.allowsEditing = YES;
                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                             
                                             [self presentViewController:picker animated:YES completion:NULL];
                                             */
                                             
                                             UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                                             imgPicker.delegate = self;
                                             imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                             
                                             [self.navigationController presentModalViewController:imgPicker animated:YES];
                                             
                                             
                                         }];
/*
    UIAlertAction *customIconsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Custom Icons", @"Custom Icons action")
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            NSLog(@"Archive action");
                                        }];
  */
    [alertController addAction:cancelAction];
    [alertController addAction:takePhotoAction];
    [alertController addAction:photoLibraryAction];
    //[alertController addAction:customIconsAction];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(IBAction)sendPressed:(id)sender
{

    [self.commentTextField resignFirstResponder];
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    //Upload a new picture
    //
    /*
     UIImage *image = YourImageView.image;
     UIImage *tempImage = nil;
     CGSize targetSize = CGSizeMake(80,60);
     UIGraphicsBeginImageContext(targetSize);
     
     CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
     thumbnailRect.origin = CGPointMake(0.0,0.0);
     thumbnailRect.size.width  = targetSize.width;
     thumbnailRect.size.height = targetSize.height;
     
     [image drawInRect:thumbnailRect];
     
     tempImage = UIGraphicsGetImageFromCurrentImageContext();
     
     UIGraphicsEndImageContext();
     
     YourImageView.image = tempImage;
     */
    

    
    NSLog(@"MyImage width %f height %f size in bytes:%i",self.imgToUpload.image.size.width,self.imgToUpload.image.size.height,[UIImagePNGRepresentation(self.imgToUpload.image) length]);

    NSData *pictureData;
    if([UIImagePNGRepresentation(self.imgToUpload.image) length]> 10485760){

        UIImage *image = self.imgToUpload.image;
        UIImage *tempImage = nil;

        
        if (self.imgToUpload.image.size.width>self.imgToUpload.image.size.height) {
            int yy=0;
            int xx = self.imgToUpload.image.size.width/1000;
            
            yy=self.imgToUpload.image.size.height/xx;
            
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
            int xx = self.imgToUpload.image.size.height/1000;
            
            yy=self.imgToUpload.image.size.width/xx;
            
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
        pictureData = UIImagePNGRepresentation(self.imgToUpload.image);
    }
    
    
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //Add the image to the object, and add the comments, the user, and the geolocation (fake)
            PFObject *imageObject = [PFObject objectWithClassName:WALL_OBJECT];
            [imageObject setObject:file forKey:KEY_IMAGE];
            [imageObject setObject:[PFUser currentUser].username forKey:KEY_USER];
            [imageObject setObject:self.commentTextField.text forKey:KEY_COMMENT];
            [imageObject setObject:@2 forKey:@"isheader"];
            
            PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:52 longitude:-4];
            [imageObject setObject:point forKey:KEY_GEOLOC];
            
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded){
                    //Go back to the wall
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    [self showErrorView:errorString];
                }
            }];
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
        
        [loadingSpinner stopAnimating];
        [loadingSpinner removeFromSuperview];       
        
    } progressBlock:^(int percentDone) {
        
    }];
}

#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo 
{
    
//    [picker dismissModalViewControllerAnimated:YES];
     [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //Place the image in the imageview
    self.imgToUpload.image = img;
    
    NSLog(@"1");
}

#pragma mark Error View


-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

#pragma mark - Image Picker Controller delegate methods
/*
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"2");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    //UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(((cell.frame.size.width-70)/2),20, 70, 70)];
    //    imv.image=[UIImage imageNamed:imgName];
    
    
    // imv.frame = CGRectMake(104, 106, 133, 133);
    
    // circle
    
    self.imgToUpload.image = chosenImage;
    
    self.imgToUpload.userInteractionEnabled = YES;

    self.imgToUpload.contentMode = UIViewContentModeScaleAspectFit;
    
    //self.imgToUpload.layer.cornerRadius = (self.imgToUpload.frame.size.width / 2);
    //self.imgToUpload.layer.borderWidth = 2.0f;
    //self.imgToUpload.layer.borderColor = [UIColor grayColor].CGColor;
    //self.imgToUpload.clipsToBounds = YES;
    
    //        imv.backgroundColor = [UIColor blueColor];
    
    
    
    
    //
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
*/
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
