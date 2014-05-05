//
//  PPAFilterController.m
//  Pull Pic
//
//  Created by T.J. Mercer on 5/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PPAFilterController.h"

@interface PPAFilterController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation PPAFilterController
{
    UIScrollView * bunchaButtons;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    NSMutableArray * namesOfButtons;
    
    float wh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                       @"CIColorInvert",
                       @"CIColorMonochrome",
                       @"CIColorPosterize",
                       @"CIFalseColor",
                       @"CIMaximumComponent",
                       @"CIMinimumComponent",
                       @"CIPhotoEffectChrome",
                       @"CIPhotoEffectFade",
                       @"CIPhotoEffectInstant",
                       @"CIPhotoEffectMono",
                       @"CIPhotoEffectNoir",
                       @"CIPhotoEffectProcess",
                       @"CIPhotoEffectTonal",
                       @"CIPhotoEffectTransfer",
                       @"CISepiaTone",
                       @"CIVignette"
                       ];
        
        bunchaButtons = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        bunchaButtons.scrollEnabled = YES;
        bunchaButtons.showsHorizontalScrollIndicator = YES;
    }
    
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewDidLoad];
    
    wh = self.view.frame.size.height -20;
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10)*i+10;
        
        UIButton * filterButton = [[UIButton alloc]initWithFrame:CGRectMake(x, 10, wh, wh)];
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        [filterButtons addObject:filterButton];
        
        [bunchaButtons addSubview:filterButton];
    };
    
    bunchaButtons.contentSize = CGSizeMake((wh +10) * [filterNames count] + 10, self.view.frame.size.height);
    [self.view addSubview:bunchaButtons];
}

- (UIImage *)filterImage:(UIImage*)image filterName:(NSString *)filterName
{
//    NSLog(@"good");
    
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    [filter setValue:ciImage forKey:kCIInputImageKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}

-(void)switchFilter: (UIButton *)filterButton
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
}

-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
    
    NSLog(@"%@", imageToFilter);
    
    for (UIButton * filterButton in filterButtons)
    {
         NSLog(@"called");
        [filterButton setImage:nil forState:UIControlStateNormal];
        
        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL),
                       ^{
                           UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh];
                           UIImage * image = [self filterImage:smallImage filterName:filterName];
                           
                           dispatch_async(dispatch_get_main_queue(), ^(void){
                               [filterButton setImage:image forState:UIControlStateNormal];
                               filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
                           });
                       });
    }
}

-(UIImage *)shrinkImage: (UIImage *)image maxWH:(int)widthHeight
{
    CGSize size = CGSizeMake(widthHeight, widthHeight/image.size.width * image.size.height);
    
    if (image.size.height < image.size.width) {
        size = CGSizeMake(widthHeight/image.size.height * image.size.width, widthHeight);
    }
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage * destImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return destImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
