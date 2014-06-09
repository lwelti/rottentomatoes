//
//  MovieCell.h
//  rottentomatoes
//
//  Created by Lucas Welti on 6/5/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;


@end
