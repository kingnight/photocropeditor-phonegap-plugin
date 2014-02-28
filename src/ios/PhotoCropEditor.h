//
//  PhotoCropEditor.h
//  crop photo plugin 
//
//  Created by aisino on 14-2-16
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface PhotoCropEditor : CDVPlugin

- (void) takePicture:(CDVInvokedUrlCommand*)command;

@end
