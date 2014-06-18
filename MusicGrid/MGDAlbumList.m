//
//  MGDAlbumList.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDAlbumList.h"
#import "MGDData.h"

@interface MGDAlbumList ()

@end

@implementation MGDAlbumList

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self= [super initWithCollectionViewLayout:layout];
    if (self)
    {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[MGDData mainData].used allKeys] count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-40) /3, (SCREEN_HEIGHT -50)/4);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIImageView * albumCover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    albumCover.image = [[MGDData mainData].used allValues][indexPath.row][@"cover"];
    albumCover.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:albumCover];

    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height -30, cell.frame.size.width, 30)];

    title.textColor = [UIColor darkGrayColor];

    title.text = [[MGDData mainData].used allKeys][indexPath.row];

    [cell.contentView addSubview:title];

    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
