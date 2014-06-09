//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/4/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "MoviesViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "MovieDetails.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *NetworkErrorLabel;





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

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    
}

- (void)refreshMyTable:(UIRefreshControl *)refreshControl {
    
    [self.tableView reloadData];
    [refreshControl endRefreshing];

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refreshControl addTarget:self
                action:@selector(refreshMyTable:)
      forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    

    
    
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
   // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.movies = responseObject[@"movies"];
        [self.tableView reloadData];

      NSLog(@"JSON: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      //  NSLog(@"Error: %@", error);
        
        NSLog(@"NETWORK ERROR");
    
        self.NetworkErrorLabel.text = @"Network Error!!";
        self.NetworkErrorLabel.backgroundColor = [UIColor blueColor];
        self.NetworkErrorLabel.layer.borderColor = [UIColor grayColor].CGColor;
        self.NetworkErrorLabel.layer.borderWidth = 1;
        self.NetworkErrorLabel.layer.cornerRadius = 1;
        self.NetworkErrorLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        self.NetworkErrorLabel.layer.shadowOffset = CGSizeMake(5, 5);
        self.NetworkErrorLabel.layer.shadowOpacity = 0.8;
        self.NetworkErrorLabel.layer.shadowRadius = 3;
        
        [self.tableView reloadData];

        
    }];
    
    

    
  
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    
   
    
    
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
