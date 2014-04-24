//
//  SLFPhoto.m
//  Selfy
//
//  Created by T.J. Mercer on 4/22/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFPhoto.h"

#import <Parse/Parse.h>

@interface SLFPhoto () <UITextViewDelegate>

@end

@implementation SLFPhoto
{
    UIImageView * newPicture;
    UITextView * newCaption;
    UIButton * create;
    UIButton * cancel;
    UIView * newForm;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        newForm = [[UIView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:newForm];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 5, SCREEN_WIDTH/3,20)];
        title.text = @"Selfy";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = CYAN_COLOR;
        
        UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        header.backgroundColor = MAGENTA_COLOR;
        [newForm addSubview:header];
        
        cancel = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 5, 20, 20)];
        cancel.backgroundColor = PURPLE_COLOR;
        cancel.layer.cornerRadius = 5;
        [header addSubview:cancel];
        [header addSubview:title];
        
        newPicture = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, SCREEN_WIDTH-80)];
        [newPicture setContentMode:UIViewContentModeScaleAspectFit];
        newPicture.image = [UIImage imageNamed:@"sunset"];
        newPicture.backgroundColor = [UIColor whiteColor];
        [[newPicture layer] setBorderWidth:2.0];
        [[newPicture layer] setBorderColor:[UIColor colorWithRed:16/255.0f green:237/255.0f blue:13/255.0f alpha:1.0f].CGColor];
//        newPicture = (@"sunset");
        [newForm addSubview:newPicture];
        
        newCaption = [[UITextView alloc]initWithFrame:CGRectMake(20, SCREEN_WIDTH-20, SCREEN_WIDTH-40, 60)];
        newCaption.backgroundColor = [UIColor whiteColor];
        newCaption.delegate = self;
        newCaption.layer.cornerRadius = 15;
        [[newCaption layer] setBorderWidth:2.0];
        [[newCaption layer] setBorderColor:[UIColor colorWithRed:16/255.0f green:237/255.0f blue:13/255.0f alpha:1.0f].CGColor];
        newCaption.keyboardType = UIKeyboardTypeTwitter;
        [newForm addSubview:newCaption];
        
        create = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_WIDTH+50, SCREEN_WIDTH/2, 80)];
        create.backgroundColor = [UIColor whiteColor];
        create.layer.cornerRadius = 40;
        [create addTarget:self action:@selector(writeCaption) forControlEvents:UIControlEventTouchUpInside];
        [[create layer] setBorderWidth:2.0];
        [[create layer] setBorderColor:[UIColor colorWithRed:16/255.0f green:237/255.0f blue:13/255.0f alpha:1.0f].CGColor];
        [create setTitle:@"SUBMIT" forState:normal];
        create.titleLabel.textColor = GREEN_COLOR;
        [newForm addSubview:create];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
//        NSData *imageData = UIImagePNGRepresentation(newPicture);
//        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
       

    }
    return self;
}

-(void)tapScreen
{
    [newCaption resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = self.view.frame;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    newPicture.alpha = .25;
}

-(void)writeCaption
{
    NSLog(@"writing");
    
    PFObject *testObject = [PFObject objectWithClassName:@"UserSelfy"];
    testObject[@"image"] = @"image.png";
    testObject[@"caption"] = newCaption.text;
    [testObject saveInBackground];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -KB_HEIGHT, SCREEN_WIDTH, self.view.frame.size.height);
    }];
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
