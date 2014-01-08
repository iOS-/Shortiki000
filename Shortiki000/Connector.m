//
//  Connector.m
//  Shortiki000
//
//  Created by Artem Karpov on 07.12.13.
//  Copyright (c) 2013 Artem Karpov. All rights reserved.
//

#import "Connector.h"

@implementation Connector
-(id)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        self.targetObject = target;
        self.responseData = [NSMutableData data];
        itemFound = titleFound = infoFound = NO;
        self.itemInfo = @"";
        self.itemTitle = @"";
        self.itemDate = @"";
        self.currentItem = [NSMutableDictionary dictionary];
        
        self.result = [NSMutableArray array];
    }
    return self;
}
-(void)requestURL:(NSString*)urlHref
{
    
    
    NSURL* needleURL = [NSURL URLWithString:urlHref];
    NSURLRequest* req = [NSURLRequest requestWithURL:needleURL];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    [conn start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//connection methods

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Loading failed" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
    [alert show];
    
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"%lu",(unsigned long)[data length]);
    [self.responseData appendData:data];
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //NSString* str = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    //str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    //NSLog(@"%@",str);
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:self.responseData];
    parser.delegate = self;
    [parser parse];
}
//XML parser methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"item"]){
        itemFound = YES;
    }
    if ( [elementName isEqualToString:@"title"] && itemFound ){
        titleFound = YES;
    }
    if ( [elementName isEqualToString:@"description"] && itemFound){
        infoFound = YES;
    }
    if ( [elementName isEqualToString:@"pubDate"] && itemFound){
        dateFound = YES;
    }
    
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"item"]){
        itemFound = NO;
        [self.result addObject:self.currentItem];
        self.currentItem = [NSMutableDictionary dictionary];
    }
    if ( [elementName isEqualToString:@"title"] && itemFound ){
        titleFound = NO;
        [self.currentItem setObject:self.itemTitle forKey:@"title"];
        //NSLog(@"%@",self.itemTitle);
        self.itemTitle = @"";
    }
    if ( [elementName isEqualToString:@"description"] && itemFound){
        infoFound = NO;
        [self.currentItem setObject:self.itemInfo forKey:@"description"];
        self.itemInfo = @"";
    }
    if ( [elementName isEqualToString:@"pubDate"] && dateFound){
        dateFound = NO;
        [self.currentItem setObject:self.itemDate forKey:@"pubDate"];
        //NSLog(@"%@",self.itemDate);
        self.itemDate = @"";
    }
    if ( [elementName isEqualToString:@"rss"]){
        [self.targetObject applyResponseArray:self.result];
    }
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (titleFound) {
        self.itemTitle = [self.itemTitle stringByAppendingString:string];
        //        NSLog(@"%@",string);
    }
    if (infoFound) {
        self.itemInfo = [self.itemInfo stringByAppendingString:string];
        //        NSLog(@"%@",string);
    }
    if (dateFound) {
        self.itemDate = [self.itemDate stringByAppendingString:string];
        //        NSLog(@"%@",string);
    }
}

@end
