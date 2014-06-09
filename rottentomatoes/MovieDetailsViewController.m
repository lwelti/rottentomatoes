//
//  MovieDetailsViewController.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/6/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "MovieDetailsViewController.h"
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
    
    NSLog(@"%@",imageUrl);
    
    
    
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url options:0 error:nil];
    
    // UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    
    
   // self.view.backgroundColor = [UIColor clearColor];
    
    
    
    
    [self.PosterView setImageWithURL:url];

    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
