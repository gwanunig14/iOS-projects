//
//  PPAViewController.m
//  Pull Pic
//
//  Created by T.J. Mercer on 4/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PPAViewController.h"

#import "PPAFilterController.h"

#import "BlurViewController.h"

#import "ControlsViewController.h"

#import "HSBColorControlVC.h"

@interface PPAViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,PPAFilterControllerDelegate,BlurViewControllerDelegate,ControlsViewControllerDelegate,HSBColorControlVCDelegate>

@property (nonatomic) UIImage * originalImage;

@end

@implementation PPAViewController
{
    ControlsViewController * conController;
    BlurViewController * blurVC;
    PPAFilterController * filterVC;
    HSBColorControlVC * colorVC;
    UIImageView * backgroundPicture;
    UIView * edittingTable;
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
    
//    edittingTable = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 140)];
//    [self.view addSubview:edittingTable];
    
    UIButton * changeBackgroundPicture = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    changeBackgroundPicture.layer.cornerRadius = changeBackgroundPicture.frame.size.height/2;
    changeBackgroundPicture.backgroundColor = [UIColor redColor];
    [changeBackgroundPicture addTarget:self action:@selector(newBackground) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:changeBackgroundPicture];
    
    conController = [[ControlsViewController alloc]initWithNibName:nil bundle:nil];
    conController.delegate = self;
    conController.view.frame = CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 40);
    [self.view addSubview:conController.view];
    
    colorVC = [[HSBColorControlVC alloc]initWithNibName:nil bundle:nil];
    colorVC.delegate = self;
    colorVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);
    
    filterVC = [[PPAFilterController alloc]initWithNibName:nil bundle:nil];
    filterVC.delegate = self;
    filterVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
//    [self.view addSubview:filterVC.view];
    
    blurVC = [[BlurViewController alloc]initWithNibName:nil bundle:nil];
    blurVC.delegate = self;
    blurVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
//    [self.view addSubview:blurVC.view];
    
}

-(void)newBackground
{
    UIImagePickerController * photos = [[UIImagePickerController alloc]init];
    
    photos.delegate = self;
//    photos.allowsEditing = YES;
    
    [self presentViewController: photos animated:YES completion:^{
        nil;
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectFilter
{
    [self clearEdits];
    [self.view addSubview:filterVC.view];
}

-(void)selectBlur
{
    [self clearEdits];
    [self.view addSubview:blurVC.view];
}

-(void)selectHsb
{
    [self clearEdits];
    [self.view addSubview:colorVC.view];
}

-(void)clearEdits
{
    [blurVC.view removeFromSuperview];
    [filterVC.view removeFromSuperview];
    [colorVC.view removeFromSuperview];
}

-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    blurVC.imageToFilter = originalImage;
    filterVC.imageToFilter = originalImage;
    backgroundPicture.image = originalImage;
}

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image
{
    backgroundPicture.image = image;
    self.originalImage = image;
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
