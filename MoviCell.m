//
//  MoviCell.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/5/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "MoviCell.h"

@implementation MoviCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
