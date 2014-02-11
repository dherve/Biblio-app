//
//  AboutVIewController.m
//  Biblios
//

#import "AboutVIewController.h"
#import "UIStyles.h"
#import "XML_TAGS.h"
#import "XMLHandler.h"
@interface AboutVIewController(PrivateAPI)
    -(NSString *) loadText:(NSString *) source;
@end

@implementation AboutVIewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
    [m_aboutDescriptionLabel release];
    [super dealloc];
}

#pragma mark - View lifecycle

-(void) loadView
{
    [super loadView];
    //m_viewTitle = NSLocalizedString(@"About", @"About screen title");
    CGFloat y = 0;
    CGFloat x = CELL_PADDING_LEFT;
    CGFloat width = HEADER_WIDTH - (CELL_PADDING_LEFT * 2);
    CGFloat height = APPLICATION_HEIGHT / 2; 
    
    m_header = [[BaseHeader alloc]initWithFrame:CGRectMake(x, y,HEADER_WIDTH,
                                                           HEADER_HEIGHT)];
    [m_header setTextContent:NSLocalizedString(@"THE APPLICATION", 
                                               @"Title for the screen to search for item")
                     subText:NSLocalizedString(@"About", 
                                               @"Text for the screen to add a new item")];
    [m_view addSubview:m_header];
    
    y += HEADER_HEIGHT;
    x += CELL_PADDING_LEFT;

    // Here we set everythinh manually since we want the text to be justified.
    m_aboutDescriptionLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [m_aboutDescriptionLabel setFont:[UIStyles getFont:CONTENT_FONT]];
    [m_aboutDescriptionLabel setTextColor:[UIStyles getColor:CONTENT_TEXT_COLOR]];
    [m_aboutDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    m_aboutDescriptionLabel.textAlignment = UITextAlignmentJustify;
    m_aboutDescriptionLabel.numberOfLines = 0;
    m_aboutDescriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    m_aboutDescriptionLabel.shadowColor = [UIColor whiteColor];
    m_aboutDescriptionLabel.shadowOffset = CGSizeMake(0,1);
    [m_aboutDescriptionLabel setText:[self loadText:@"ABOUT"]];
    [m_view addSubview:m_aboutDescriptionLabel];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - private api methods
-(NSString *) loadText:(NSString *) source
{
    NSString *text = @"";
    if(source != nil)
    {
        GDataXMLDocument *document = [XMLHandler loadXMLFile:source];
        if(document != nil)
        {
            GDataXMLElement *root = document.rootElement;
            text = [XMLHandler elementValueAsString:root forTag:ABOUT_TEXT];
        }
    }
    return text;
}
@end
