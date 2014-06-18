//
//  EXPViewController.h
//  Experiment
//
//  Created by T.J. Mercer on 6/9/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+Draggable.h"

@interface EXPViewController : UICollectionViewController <UICollectionViewDataSource_Draggable>
@property (nonatomic) NSMutableArray * fill;

@end
