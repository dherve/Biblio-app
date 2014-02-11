//
//  RequestHandler.h
//  Biblios
//
//  Handle request to be sent by the application.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@interface RequestHandler : NSObject

/**
 *  Send a request and create an aobject ot handle the response.
 *  @param : request the request to send.
 */
+(void)sendRequest:(Request *) request;

/**
 * Get the data received as response for a specific request.
 * @param : urlRequest request url.
 */
+(NSMutableData *) getDataForRequest:(NSString *) urlRequest;
@end
