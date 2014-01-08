//
//  ViewController.h
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, retain) NSArray* tableSource;
- (IBAction)RandBtn:(id)sender;
- (IBAction)TOPBtn:(id)sender;
- (IBAction)LastBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *RandBtnOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *LastBtnOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TopBtnOutlet;

- (void) showShorts:(NSString *)paramFormat withType:(NSString *)paramType andAmount:(NSString *)paramAmount;

@end
