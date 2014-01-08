//
//  ViewController.m
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "Connector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableSource = [NSArray array];
    self.tableView.backgroundColor = [UIColor grayColor];
    
    Connector* ctr = [[Connector alloc] initWithTarget:self];
    [ctr requestURL:@"http://shortiki.com/export/api.php?format=xml&type=random&amount=50"];
    self.RandBtnOutlet.tintColor = [UIColor blueColor];
    self.TopBtnOutlet.tintColor = [UIColor grayColor];
    self.LastBtnOutlet.tintColor = [UIColor grayColor];

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ids = @"MyCell";
    
    MyCell* cell = [tableView dequeueReusableCellWithIdentifier:ids];
    
    cell.descLabel.text = [[self.tableSource objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.numLabel.text = [[self.tableSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.dateLabel.text = [[self.tableSource objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString * ids = @"MyCell";
    
   // MyCell* cell = [tableView dequeueReusableCellWithIdentifier:ids];
    
//    cell.descLabel.text = [[self.tableSource objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    return 70;
}


-(void)applyResponseArray:(NSArray *)list
{
    //    UIView* preloader = [self.view viewWithTag:444];
    //    preloader.hidden = YES;
    
    self.tableSource = list;
    
    UITableView* table = (UITableView*)[self.view viewWithTag:777];
    //table.delegate = self;
    //table.dataSource = self;
    [table reloadData];
}

- (void) showShorts:(NSString *)paramFormat withType:(NSString *)paramType andAmount:(NSString *)paramAmount {
    
    self.tableSource = [NSArray array];
    
    NSString *resultURL = @"http://shortiki.com/export/api.php?";
    
    resultURL = [resultURL stringByAppendingString:paramFormat];
    resultURL = [resultURL stringByAppendingString:paramType];
    resultURL = [resultURL stringByAppendingString:paramAmount];
    
    Connector* ctr = [[Connector alloc] initWithTarget:self];
    [ctr requestURL:resultURL];
    
}

- (IBAction)RandBtn:(id)sender {
    [self showShorts:@"format=xml" withType:@"&type=random" andAmount:@"&amount=50"];
   
    self.RandBtnOutlet.tintColor = [UIColor blueColor];
    self.TopBtnOutlet.tintColor = [UIColor grayColor];
    self.LastBtnOutlet.tintColor = [UIColor grayColor];
    
}

- (IBAction)TOPBtn:(id)sender {
    [self showShorts:@"format=xml" withType:@"&type=top" andAmount:@"&amount=50"];
    self.RandBtnOutlet.tintColor = [UIColor grayColor];
    self.TopBtnOutlet.tintColor = [UIColor blueColor];
    self.LastBtnOutlet.tintColor = [UIColor grayColor];
}

- (IBAction)LastBtn:(id)sender {
    [self showShorts:@"format=xml" withType:@"&type=index" andAmount:@"&amount=50"];
    self.RandBtnOutlet.tintColor = [UIColor grayColor];
    self.TopBtnOutlet.tintColor = [UIColor grayColor];
    self.LastBtnOutlet.tintColor = [UIColor blueColor];
}
@end
