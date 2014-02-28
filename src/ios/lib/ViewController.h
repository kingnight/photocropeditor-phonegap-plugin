//
//  ViewController.h
//  ImageEditor
//
//  Created by pioneer on 14-2-17.
//  Copyright (c) 2014年 Heitor Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

- (void)ViewControllerDelegateDidCancel:(ViewController *)controller;
- (void)ViewControllerDelegateDidSave:(ViewController *)controller;

@end

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (nonatomic,strong) NSString *savePathURL;
@property (nonatomic, weak) id <ViewControllerDelegate> delegate;
-(void)setCropSizeWidth:(CGFloat)width andHeight:(CGFloat)height;
@end
