//
//  DVDViewController.m
//  rottentomatoes
//
//  Created by Lucas Welti on 6/7/14.
//  Copyright (c) 2014 Yahoo!. All rights reserved.
//

#import "DVDViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "MovieDetails.h"


@interface DVDViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dvds;


@end

@implementation DVDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"DVD";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    /*
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection
     sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         NSLog(@"%@", object);
         
         self.dvds = object[@"movies"];
         [self.tableView reloadData];
         
         if ( connectionError){
             
             NSLog(@"error");
             
         }
         
     }];
    */
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.dvds = responseObject[@"movies"];
        [self.tableView reloadData];
        
        NSLog(@"JSON: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"Error: %@", error);
        
        NSLog(@"NETWORK ERROR");
        
        
        
       // self.NetworkErrorLabel.text = @"Network Error";
        
        
        
        
    }];

    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    
    
    //self.title = @"Movies";
    
    
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"Number of movies %lu", (unsigned long)self.dvds.count);
    
    return 10;
}


- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    
    NSDictionary *movie = self.dvds[indexPath.row];
    
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    
    
    
    NSString *imageUrl = movie[@"posters"][@"thumbnail"];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    
    [cell.posterView setImageWithURL:url];
    
    cell.movieTitleLabel.text = movie[@"title"];
    cell.movieSynopsisLabel.text = movie[@"synopsis"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    cell.tag = indexPath.row;
    
 //  [cell addGestureRecognizer:tap];
    
    
    
    
    
    return cell;
}


@end
