#import "HFImageEditorViewController+Private.h"
#import "DemoImageEditor.h"

@interface DemoImageEditor ()
@property (nonatomic) CGFloat editorCropHeight;
@property (nonatomic) CGFloat editorCropWidth;

@end

@implementation DemoImageEditor

@synthesize  saveButton = _saveButton;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        //self.cropRect = CGRectMake(0,0,320,320);
        self.minimumScale = 0.2;
        self.maximumScale = 10;
    }
    return self;
}

//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.cropRect = CGRectMake((self.frameView.frame.size.width-self.editorCropWidth)/2.0f, (self.frameView.frame.size.height-self.editorCropHeight)/2.0f, self.editorCropWidth, self.editorCropHeight);
//    [self reset:YES];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cropRect = CGRectMake((self.frameView.frame.size.width-self.editorCropWidth)/2.0f, (self.frameView.frame.size.height-self.editorCropHeight)/2.0f, self.editorCropWidth, self.editorCropHeight);
    [self reset:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.saveButton = nil;
}

-(void)setCropSizeWidth:(CGFloat)width andHeight:(CGFloat)height
{
    CGFloat aspect=height/width;
    if (aspect>1) {
        self.editorCropHeight=320;
        self.editorCropWidth=self.editorCropHeight/aspect;
    }
    else
    {
        self.editorCropWidth=320;
        self.editorCropHeight=aspect*self.editorCropWidth;
    }

    self.outputWidth=width;
    
    //NSLog(@"editorCropWidth＝%f,editorCropHeight=%f",self.editorCropWidth,self.editorCropHeight);
}

- (IBAction)setSquareAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-320)/2.0f, (self.frameView.frame.size.height-320)/2.0f, 320, 320);
    [self reset:YES];
}

- (IBAction)setLandscapeAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-320)/2.0f, (self.frameView.frame.size.height-240)/2.0f, 320, 240);
    [self reset:YES];
}


- (IBAction)setLPortraitAction:(id)sender
{
    self.cropRect = CGRectMake((self.frameView.frame.size.width-240)/2.0f, (self.frameView.frame.size.height-320)/2.0f, 240, 320);
    [self reset:YES];
}

#pragma mark Hooks
- (void)startTransformHook
{
    self.saveButton.tintColor = [UIColor colorWithRed:0 green:49/255.0f blue:98/255.0f alpha:1];
}

- (void)endTransformHook
{
    self.saveButton.tintColor = [UIColor colorWithRed:0 green:128/255.0f blue:1 alpha:1];
}


@end
