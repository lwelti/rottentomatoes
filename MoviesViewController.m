//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/4/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "MoviesViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "MovieDetails.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *movies;




@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Box Office";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection
        sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        
        self.movies = object[@"movies"];
        [self.tableView reloadData];
        
        if ( connectionError){
            
            NSLog(@"error");
            
        }

    }];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    
    
    //self.title = @"Movies";
    
    

    
    
}



- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    
    
    MovieDetailsViewController *mdc = [[MovieDetailsViewController alloc] init];
    

    
    NSLog(@" %ld", (long)recognizer.self.view.tag);
    
    NSDictionary *movie = self.movies[recognizer.self.view.tag];
    
    mdc.tempTittle =movie[@"title"];
    mdc.tempSynopsis = movie[@"synopsis"];
    
    
    NSString *posterUrl = movie[@"posters"][@"original"];
    
NSString *imageUrl = movie[@"posters"][@"thumbnail"];
    
        mdc.tempPoster = posterUrl;
    mdc.tempThumbnail = imageUrl;
    
    
    
    

    
    
     [self.navigationController pushViewController:mdc animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"Number of movies %lu", (unsigned long)self.movies.count);
    
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    
    
    
    NSString *imageUrl = movie[@"posters"][@"thumbnail"];

    NSURL *url = [NSURL URLWithString:imageUrl];
    

    [cell.posterView setImageWithURL:url];
    
    cell.movieTitleLabel.text = movie[@"title"];
    cell.movieSynopsisLabel.text = movie[@"synopsis"];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    cell.tag = indexPath.row;
    
    [cell addGestureRecognizer:tap];
    
    
    
    
    
    return cell;
}



@end
