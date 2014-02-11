//
//  ResponseHandler.h
//  Biblios
//
//  Handle the incoming response for a given request previousely sent by the client.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@interface ResponseHandler : NSObject<NSURLConnectionDelegate>
{
    NSMutableData   *m_data;
    Request         *m_request;
    NSString        *m_errorMessage;
    BOOL            m_startedReceivingData;
}

/**
 * Initialize a new response handler for a specific request.
 * @param : request the request to handle.
 */
-(id) initWithRequest:(Request *) request;

/**
 * @return the data received as response from the request.
 */
-(NSMutableData *) getResponseData;

/**
 * @return the error message.
 */
-(NSString *) getErrorMessage;
@end
