//
//  PPAViewController.m
//  Pull Pic
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PPAViewController.h"

#import "PPAFilterController.h"

@interface PPAViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic) UIImage * currentImage;

@end

@implementation PPAViewController
{
    PPAFilterController * filterVC;
    UIImageView * backgroundPicture;
    UIScrollView * bunchaButtons;
    NSArray * allButtons;
    NSMutableArray * namesOfButtons;
}

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
    backgroundPicture = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:backgroundPicture];
    backgroundPicture.backgroundColor = [UIColor blueColor];
    backgroundPicture.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [self.view addSubview:header];
    header.backgroundColor = [UIColor blackColor];
    
    filters = [@{} mutableCopy];
    allButtons = @[
//                             @"CIColorCrossPolynomial",
//                             @"CIColorCube",
//                             @"CIColorCubeWithColorSpace",
                             @"CIColorInvert",
//                             @"CIColorMap",
                             @"CIColorMonochrome",
                             @"CIColorPosterize",
                             @"CIFalseColor",
//                             @"CIMaskToAlpha",
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
                             @"CIVignette",
//                             @"CIVignetteEffect"
                             ];
    
    namesOfButtons = [@[] mutableCopy];
    
    bunchaButtons = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100)];
    bunchaButtons.backgroundColor = [UIColor blackColor];
    bunchaButtons.scrollEnabled = YES;
    bunchaButtons.showsHorizontalScrollIndicator = YES;
    bunchaButtons.contentSize = CGSizeMake([allButtons count] * 100, 100);
    [self.view addSubview:bunchaButtons];
    
    for (NSString * button in allButtons)
    {
        NSInteger index = [allButtons indexOfObject:button];
        UIButton * whiteButton = [[UIButton alloc]initWithFrame:CGRectMake((index * 90)+10, 10, 80, 80)];
//        whiteButton. = button;
        [whiteButton addTarget:self action:@selector(changeFilter:) forControlEvents:UIControlEventTouchUpInside];
        whiteButton.backgroundColor = [UIColor whiteColor];
        
        [namesOfButtons addObject:whiteButton];
        
        [bunchaButtons addSubview:whiteButton];
    };
    
    UIButton * changeBackgroundPicture = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    changeBackgroundPicture.layer.cornerRadius = changeBackgroundPicture.frame.size.height/2;
    changeBackgroundPicture.backgroundColor = [UIColor redColor];
    [changeBackgroundPicture addTarget:self action:@selector(newBackground) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:changeBackgroundPicture];
}

-(void)newBackground
{
    UIImagePickerController * photos = [[UIImagePickerController alloc]init];
    
    photos.delegate = self;
    photos.allowsEditing = YES;
    
    [self presentViewController: photos animated:YES completion:^{
        nil;
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    backgroundPicture.image = info[UIImagePickerControllerEditedImage];
    NSLog(@"%@", backgroundPicture.image);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
    
}

-(void)changeFilter: (UIButton*)sender
{

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

- (BOOL)prefersStatusBarHidden { return YES; }

@end
