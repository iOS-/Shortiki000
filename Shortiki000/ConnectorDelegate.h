//
//  ConnectorDelegate.h
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectorDelegate <NSObject>
@required
-(void)applyResponseArray:(NSArray*)list;
@end
