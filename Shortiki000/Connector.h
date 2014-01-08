//
//  Connector.h
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectorDelegate.h"

@interface Connector : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSXMLParserDelegate>
{
    BOOL itemFound;
    BOOL titleFound;
    BOOL infoFound;
    BOOL dateFound;
}
@property (readwrite,nonatomic,retain) id<ConnectorDelegate>targetObject;
@property (readwrite,nonatomic,retain) NSMutableData* responseData;
@property (readwrite,nonatomic,retain) NSMutableArray* result;
@property (readwrite,nonatomic,retain) NSMutableDictionary* currentItem;
@property (readwrite,nonatomic,retain) NSString* itemTitle;
@property (readwrite,nonatomic,retain) NSString* itemInfo;
@property (readwrite,nonatomic,retain) NSString* itemDate;

-(id)initWithTarget:(id)target;
-(void)requestURL:(NSString*)urlHref;
@end
