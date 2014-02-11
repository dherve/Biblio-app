//
//  XMLParser.h
//  Biblios
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "XmlResultSet.h"
@interface XMLHandler : NSObject

/**
 * Load an xml from an xml string
 * @param : xmlString the string with the xml file to load
 * @return : The root node of the document if the xml was successfully loaded;
 *           nil otherwise.
 */
+(GDataXMLDocument *)loadXMLFileFromString:(NSString *) xmlString;

/**
 * Load an xml file
 * @param : xmlFileName the name of the xml file to load
 * @return : The root node of the document if the xml was successfully loaded;
 *           nil otherwise.
 */
+(GDataXMLElement *)loadXMLFile:(NSString *) xmlFileName;

/**
 * Get an element with the specific tag name
 * @param : xmlElement the xml element containing the element to get.
 * @param : xmlTagName the tag of the element ot get.
 * @return : element to get if found, nil otherwise.
 */
+(GDataXMLElement *) elementForTag:(GDataXMLElement *) xmlElement 
                            forTag:(NSString *)xmlTagName;

/**
 * Get the string value of an xml element.
 * @param : xmlElement the xml node containing the value
 * @param : xmlTagName the tag enclosing the value within the node.
 * @return : the value of the node as a string if set, nil otherwise.
 */
+(NSString *) elementValueAsString:(GDataXMLElement *) xmlElement 
                            forTag:(NSString*) xmlTagName;

/**
 * Get the number value of an xml element.
 * @param : xmlElement the xml node containing the value
 * @param : xmlTagName the tag enclosing the value within the node.
 * @return : the value of the node as a number if set, nil otherwise.
 */
+(NSNumber *) elementValueAsNumber:(GDataXMLElement *) xmlElement 
                            forTag:(NSString*) xmlTagName;


/**
 * Get the child elements of an xml element.
 * @param : xmlElement the xml node with child nodes.
 * @param : xmlTagName the tag associated to the node.
 * @return : the array of childs nodes if any, nil otherwise.
 */
+(NSArray *) elementChildren:(GDataXMLElement *) xmlElement 
                      forTag:(NSString*) xmlTagName;

/**
 * Execute an XPath query on an xml path.
 * @param : xmlDocument the document to which the query will be executed.
 * @param : xpathQuery the query to execute.
 * @return : A set containing the nodes resulting from the query execution.
 */
+(XmlResultSet *) executeXpathQuery:(GDataXMLDocument *) xmlDocument 
                          withQuery:(NSString *) xpathQuery;



@end
