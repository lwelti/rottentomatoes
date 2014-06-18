//
//  MovieDetailsViewController.h
//  rottentomatoes
//
//  Created by Lucas Welti on 6/6/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"


@interface MovieDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *movieDetailTitle;

@property (weak, nonatomic) IBOutlet UILabel *movieDetailSynopsis;



@property NSString *tempTittle;
@property NSString *tempSynopsis;
@property NSString *tempPoster;
@property NSString *tempThumbnail;
@property int movieId;

@property (weak, nonatomic) IBOutlet UIImageView *PosterView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;





@end
