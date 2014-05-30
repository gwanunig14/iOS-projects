//
//  GLACollectionViewController.m
//  GridLayout
//
//  Created by T.J. Mercer on 5/30/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "GLACollectionViewController.h"

@interface GLACollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation GLACollectionViewController
{
    NSArray * movies;
}

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self= [super initWithCollectionViewLayout:layout];
    if (self)
    {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        movies = @[
                   @"Congo",
                   @"Godzilla",
                   @"Big",
                   @"Babe",
                   @"Bambi",
                   @"Batman",
                   @"Pi",
                   @"Hook",
                   @"Prime",
                   @"Mask",
                   @"Ed",
                   @"Go",
                   @"Jaws",
                   @"ET",
                   @"Alien",
                   @"Aliens"
                   ];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [movies count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-40) /3, (SCREEN_HEIGHT -50)/4);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, cell.frame.size.width -20, 30)];
    
    title.textColor = [UIColor darkGrayColor];
    
    title.text = movies[indexPath.row];
    
    [cell.contentView addSubview:title];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
