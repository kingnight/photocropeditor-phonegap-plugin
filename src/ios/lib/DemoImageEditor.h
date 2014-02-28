#import "HFImageEditorViewController.h"

@interface DemoImageEditor : HFImageEditorViewController

@property(nonatomic,strong) IBOutlet UIBarButtonItem *saveButton;
-(void)setCropSizeWidth:(CGFloat)width andHeight:(CGFloat)height;
@end
