//
//  MyCell.h
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *numLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@end
