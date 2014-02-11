//
//  RequestHandler.m
//  Biblios
//

#import "RequestHandler.h"
#import "GDataXMLNode.h"
#import "Notifications.h"
#import "ResponseHandler.h"
@interface RequestHandler(PrivateAPI)
@end

@implementation RequestHandler

static NSMutableDictionary *m_connections;
static NSMutableDictionary *m_responseHandlers;

+(void)sendRequest:(Request *) request // <- is this asnc ? or sync ?
{
    if(m_connections == nil || m_responseHandlers == nil)
    {
        m_connections = [[NSMutableDictionary alloc] init];
        m_responseHandlers = [[NSMutableDictionary alloc] init];
    }
    NSString *url = [request getURL];
    NSURLRequest *nsrequest =[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                            cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                        timeoutInterval:60.0];
    
    // Create a hanlder for the request to be sent.
    ResponseHandler *handler = [[[ResponseHandler alloc] initWithRequest:request] retain];
    
    // Create also the corresponding connection.
    NSURLConnection *connection =[[NSURLConnection alloc]
                                  initWithRequest:nsrequest delegate:handler];
    
    
    if (connection) {
        [m_connections setObject:connection forKey:url];
        [m_responseHandlers setObject:handler forKey:url];
    } else {
        // Release whatever we created before.
        [handler release];
        [connection release];
        
        // Notify whoever is interested by the request that it failed.
        NSMutableDictionary *infos = [[NSMutableDictionary alloc] init];
        [infos setObject:url forKey:NOTIFICATION_KEY_REQUEST_URL];
        [[NSNotificationCenter defaultCenter]postNotificationName:REQUEST_FAILED_NOTIFICATION 
                                                           object:nil 
                                                         userInfo:infos];
    }    
}

+(NSMutableData *) getDataForRequest:(NSString *) urlRequest
{
    NSMutableData *data = nil;
    if(urlRequest != nil)
    {
        ResponseHandler *handler = [m_responseHandlers objectForKey:urlRequest];
        
        // Get the data from the corresponding handler.
        data = [[NSMutableData alloc] initWithData:[handler getResponseData]];
        
        // Release the object as they are no longer needed
        [m_connections removeObjectForKey:urlRequest];
        [m_responseHandlers removeObjectForKey: urlRequest];
    }
    return  data;
}

@end
