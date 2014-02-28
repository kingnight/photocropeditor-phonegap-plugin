//
//  PhotoCropEditor.h
//  crop photo plugin 
//
//  Created by aisino on 14-2-16
//
//

#import "PhotoCropEditor.h"
#import "ViewController.h"

@interface PhotoCropEditor () <ViewControllerDelegate>
@property(nonatomic,strong)NSString *callbackID;
@property(nonatomic,strong) ViewController *cropviewcontroller;
@end

@implementation PhotoCropEditor


- (void) takePicture:(CDVInvokedUrlCommand*)command {
	
    NSString* width = [command argumentAtIndex:0];
    NSString* height= [command argumentAtIndex:1];
    
    CGFloat inputWidth=[width floatValue];
    CGFloat inuputHeight=[height floatValue];
    
    CDVPluginResult* pluginResult;
    self.callbackID=command.callbackId;
    
    //max 2448*3264
    if (inputWidth<=0 || inuputHeight <=0 || inputWidth>2448 || inuputHeight >3264) {
        //error
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"input error"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        self.cropviewcontroller=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.cropviewcontroller setCropSizeWidth:[width floatValue] andHeight:[height floatValue]];
        self.cropviewcontroller.delegate=self;
        
        [self.viewController presentViewController:self.cropviewcontroller animated:YES completion:NULL ];
    }
    
}


#pragma marks

- (void)ViewControllerDelegateDidCancel:(ViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)ViewControllerDelegateDidSave:(ViewController *)controller;
{
    NSString *text=self.cropviewcontroller.savePathURL;
    NSLog(@"savePathURL = %@",text);
    
    CDVPluginResult* pluginResult;
    if (text!=nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    }
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end