//
//  ViewController.m
//  ImageEditor
//
//  Created by pioneer on 14-2-17.
//  Copyright (c) 2014年 Heitor Ferreira. All rights reserved.
//

#import "ViewController.h"
#import "DemoImageEditor.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define CDV_PHOTO_PREFIX @"aisno_photo_"

@interface ViewController () <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property(nonatomic,strong) DemoImageEditor *imageEditor;
@property(nonatomic,strong) ALAssetsLibrary *library;

@property (nonatomic) CGFloat outHeight;
@property (nonatomic) CGFloat outWidth;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.savePathURL=nil;
    }
    return self;
}
-(void)setCropSizeWidth:(CGFloat)width andHeight:(CGFloat)height
{
    self.outWidth=width;
    self.outHeight=height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    [actionSheet showFromToolbar:self.toolbar];
    
}

-(NSString*)savePhotoAndGetURI:(UIImage *)image
{
    if (image==nil) {
        NSLog(@"savePhotoAndGetURI input param error");
    }
    // write to temp directory and return URI
    // get the temp directory path
    NSData* data = nil;
    NSString* URI=nil;
    
    data = UIImagePNGRepresentation(image);
    
    NSString* docsPath = [NSTemporaryDirectory()stringByStandardizingPath];
    NSError* err = nil;
    NSFileManager* fileMgr = [[NSFileManager alloc] init];
    // generate unique file name
    NSString* filePath;
    
    int i = 1;
    do {
        filePath = [NSString stringWithFormat:@"%@/%@%03d.%@", docsPath, CDV_PHOTO_PREFIX, i++, @"png"];
    } while ([fileMgr fileExistsAtPath:filePath]);
    
    // save file
    if (![data writeToFile:filePath options:NSAtomicWrite error:&err]) {
        //result = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION messageAsString:[err localizedDescription]];
        URI=nil;
        
    } else {
        //result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSURL fileURLWithPath:filePath] absoluteString]];
        URI=[[NSURL fileURLWithPath:filePath] absoluteString];
    }

    return URI;
}

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:controller animated:YES completion:NULL];
    
    __weak ViewController *Myviewcontroller=self;
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.imageEditor = [[DemoImageEditor alloc] initWithNibName:@"DemoImageEditor" bundle:nil];
    self.imageEditor.checkBounds = YES;
    self.imageEditor.rotateEnabled = YES;
    self.library = library;
    
    //add new api
    [self.imageEditor setCropSizeWidth:self.outWidth andHeight:self.outHeight];
    
    self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
        if(!canceled) {
            [library writeImageToSavedPhotosAlbum:[editedImage CGImage]
                     orientation:(ALAssetOrientation)editedImage.imageOrientation
                     completionBlock:^(NSURL *assetURL, NSError *error){
                        if (error) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving"
                                                                    message:[error localizedDescription]
                                                                    delegate:nil
                                                                    cancelButtonTitle:@"Ok"
                                                                    otherButtonTitles: nil];
                            [alert show];
                        }
                        else{
                            Myviewcontroller.imageview.image=editedImage;
                        }
                    }];

            
        }
//        [controller popToRootViewControllerAnimated:YES];
//        [controller setNavigationBarHidden:NO animated:YES];
        [controller dismissViewControllerAnimated:YES completion:NULL];
    };
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:YES completion:NULL];
    
    __weak ViewController *Myviewcontroller=self;
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.imageEditor = [[DemoImageEditor alloc] initWithNibName:@"DemoImageEditor" bundle:nil];
    self.imageEditor.checkBounds = YES;
    self.imageEditor.rotateEnabled = YES;
    self.library = library;
    
    //add new api
    [self.imageEditor setCropSizeWidth:self.outWidth andHeight:self.outHeight];
    
    self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
        if(!canceled) {
            [library writeImageToSavedPhotosAlbum:[editedImage CGImage]
                     orientation:(ALAssetOrientation)editedImage.imageOrientation
                     completionBlock:^(NSURL *assetURL, NSError *error){
                            if (error) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving"
                                                                message:[error localizedDescription]
                                                                delegate:nil
                                                                cancelButtonTitle:@"Ok"
                                                                otherButtonTitles: nil];
                                [alert show];
                            }
                            else{
                                Myviewcontroller.imageview.image=editedImage;
                            }
                    }];
        }
//        [controller popToRootViewControllerAnimated:YES];
//        [controller setNavigationBarHidden:NO animated:YES];
        [controller dismissViewControllerAnimated:YES completion:NULL];
    };
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //self.imageview.image = image;
    
    //UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        UIImage *preview = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
        
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = preview;
        [self.imageEditor reset:NO];
        self.imageview.image = preview;
        
        [picker pushViewController:self.imageEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Failed to get asset from library");
    }];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel"
//                                                    message:@"Nowhere to go my friend. This is a demo."
//                                                   delegate:nil
//                                          cancelButtonTitle:@"Ok"
//                                          otherButtonTitles: nil];
//    [alert show];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (IBAction)doneAction:(id)sender {
    self.savePathURL=[self savePhotoAndGetURI:self.imageview.image];
    
    [self.delegate ViewControllerDelegateDidSave:self];
}
- (IBAction)cancelAction:(id)sender {
    [self.delegate ViewControllerDelegateDidCancel:self];
}



@end
