//
//  ResponseHandler.m
//  Biblios
//

#import "ResponseHandler.h"
#import "Notifications.h"
#import "Utilis.h"
@implementation ResponseHandler

-(id) initWithRequest:(Request *) request
{
    self = [super init];
    if(self)
    {
        m_data = [[NSMutableData alloc] init];
        m_request = [request retain];
        m_startedReceivingData = NO;
    }
    return self;
}

-(NSMutableData *) getResponseData
{
    return m_data;
}

-(NSString *) getErrorMessage
{
    return m_errorMessage;
}

-(void) dealloc
{
    [m_data release];
    [m_request release];
    [m_errorMessage release];
    [super dealloc];
}

#pragma mark - request delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    m_errorMessage = [Utilis getErrorDescription:error];
    NSMutableDictionary *infos =  [[NSMutableDictionary alloc] init];
    [infos setObject:[m_request getURL] forKey:NOTIFICATION_KEY_REQUEST_URL];
    [infos setObject:[Request requestTypeDescription:[m_request getType]] 
              forKey:NOTIFICATION_KEY_REQUEST_TYPE];
    [infos setObject:m_errorMessage forKey:NOTIFICATION_KEY_REQUEST_FAILURE_REASON];
    [[NSNotificationCenter defaultCenter]postNotificationName:REQUEST_FAILED_NOTIFICATION 
                                                       object:nil userInfo:infos];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Are we concerned by the response
    if([[[response URL] absoluteString] isEqualToString:[m_request getURL]])
    {
        m_startedReceivingData = YES;
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(m_startedReceivingData)
    {
        [m_data appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Prepare all the infos to post with the notifications
    NSMutableDictionary *infos = [[NSMutableDictionary alloc] init];
    [infos setObject:[m_request getURL] forKey:NOTIFICATION_KEY_REQUEST_URL];
    [infos setObject:[Request requestTypeDescription:[m_request getType]] 
              forKey:NOTIFICATION_KEY_REQUEST_TYPE];
    [[NSNotificationCenter defaultCenter]postNotificationName:REQUEST_COMPLETED_NOTIFICATION 
                                                       object:nil 
                                                     userInfo:infos];    
}


@end
