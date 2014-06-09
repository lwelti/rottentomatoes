//
//  MovieDetailsViewController.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/6/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface MovieDetailsViewController ()





@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    self.navigationItem.title = self.tempTittle;

    
    self.movieDetailTitle.text = self.tempTittle;
    
    self.movieDetailSynopsis.text = self.tempSynopsis;
    
    NSString *imageUrl = self.tempThumbnail;
    
    NSString *posterUrl = self.tempPoster;
    
    
    NSLog(@"%@",imageUrl);
    
    
    
    
    
    
   // imageView.image = [UIImage imageWithColor:color];
    
    
    NSURL *url = [NSURL URLWithString:posterUrl];

    
    [self.PosterView setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    

    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
