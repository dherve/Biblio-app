//
//  XMLParser.m
//  Biblios
//

#import "XMLHandler.h"
#import "XML_TAGS.h"
#import "Library.h"
#import "Utilis.h"
@implementation XMLHandler
#pragma mark -
#pragma mark generic methods for search

#pragma mark -
#pragma mark xml hanlder methods

+(GDataXMLDocument *)loadXMLFileFromString:(NSString *) xmlString
{
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] 
                                  initWithXMLString:xmlString
                                  options:0 
                                  error:&error];
    if(document != nil)
    {
        return  document ;
    }
    return nil;
}


+(GDataXMLDocument *)loadXMLFile:(NSString *)xmlFileName
{
    
    NSError *error;
    
    // Get the full path to the file
    NSString* filePath = [[NSBundle mainBundle] pathForResource: xmlFileName
                                                         ofType: @"xml"];
    
    // Get the root document
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:xmlData 
                                                                options:0 
                                                                  error:&error];
    if(document != nil)
    {
        return  document ;
    }
    return nil;
    
}

+(GDataXMLElement *) elementForTag:(GDataXMLElement *) xmlElement 
                            forTag:(NSString *)xmlTagName
{
    NSArray *values = [xmlElement elementsForName:xmlTagName];
    if(values.count > 0)
    {
        return (GDataXMLElement *) [values objectAtIndex:0];
    }
    return nil;
   
}


+(NSString *) elementValueAsString:(GDataXMLElement *)xmlElement 
                            forTag:(NSString*) xmlTagName;
{
    NSArray *values = [xmlElement elementsForName:xmlTagName];
    NSString *elementValue;
    if(values.count > 0)
    {
        GDataXMLElement *value = (GDataXMLElement *) [values objectAtIndex:0];
        elementValue = value.stringValue;
    }
    return elementValue;
}

+(NSNumber *) elementValueAsNumber:(GDataXMLElement *)xmlElement 
                            forTag:(NSString*) xmlTagName;
{
    NSArray *values = [xmlElement elementsForName:xmlTagName];
    NSNumber *elementValue;
    if(values.count > 0)
    {
        GDataXMLElement *value = (GDataXMLElement *) [values objectAtIndex:0];
        elementValue = [Utilis numberFromString:value.stringValue 
                                      withStyle:NSNumberFormatterDecimalStyle];
    }
    return elementValue;
}

+(NSArray *) elementChildren:(GDataXMLElement *) xmlElement 
                      forTag:(NSString*) xmlTagName
{
    
    NSArray *values = [xmlElement elementsForName:xmlTagName];
    NSArray *children = nil;
    if(values != nil)
    {
        GDataXMLElement *value = (GDataXMLElement *) [values objectAtIndex:0];
        children = [value children];
    }
    return children;
}

+(XmlResultSet *) executeXpathQuery:(GDataXMLDocument *) xmlDocument 
                          withQuery:(NSString *)xpathQuery
{
    XmlResultSet *resultSet = [[XmlResultSet alloc] init];
    NSError *error;
    NSArray *nodes =[xmlDocument nodesForXPath:xpathQuery error:&error];
    if( [nodes count] > 0)
    {
        resultSet.resultType = [[GDataXMLElement class] description];
        resultSet.resultArray = [NSArray arrayWithArray:nodes]; 
    }
    return resultSet;
}
@end
