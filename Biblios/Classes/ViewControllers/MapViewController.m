//
//  MapViewController.m
//  Biblios
//

#import "MapViewController.h"
#import "RequestHandler.h"
#import "XMLHandler.h"
#import "XmlResultSet.h"
#import "LocationAnnotation.h"
#import "UIStyles.h"
#import "Notifications.h"
#import "LocationHandler.h"
#import "LocationCoordinates.h"
#import "ErrorDialogHandler.h"

@interface MapViewController(PrivateAPI)
    -(void) showErrorMessage;
    -(void) showMapAnnotation;
@end

@implementation MapViewController

-(id) initWithLocation:(Address *) address locationName:(NSString *) name
{
    self = [super init];
    if(self)
    {
        m_mapView = [[MKMapView alloc] initWithFrame:
                     CGRectMake(0, 0, APPLICATION_WIDTH , APPLICATION_HEIGHT)];
        m_mapView.delegate = self;
        m_address = address;
        m_locationName = name;
        [[LocationHandler instance] requestCoordinatesForAddress:address];
    }
    return  self;    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
//    [m_address release];
//    [m_mapView release];
//    [m_searchingLabel release];
//    [m_activityIndicator release]; 
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    [self.view addSubview:m_mapView];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMapAnnotation) 
                                                 name:LOCATION_DATA_AVAILABLE_NOTIFICATION 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showErrorMessage) 
                                                 name:LOCATION_DATA_UNAVAILABLE_NOTIFICATION 
                                               object:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MKMapViewDelegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    
    static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];

    if (annotationView == nil)
    {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                       reuseIdentifier:annotationViewReuseIdentifier] autorelease];        
    }

    annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"annotation_img.png"]];
    annotationView.annotation = annotation;
    CGFloat x = annotationView.centerOffset.x; //- 15;
    CGFloat y = annotationView.centerOffset.y - 18;
    annotationView.centerOffset = CGPointMake(x, y);
    annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
    return annotationView;
}


#pragma mark - Request delegate method
-(void) showMapAnnotation
{
    LocationCoordinates *coordinates = [[LocationHandler instance] getCoordinates];
    NSString *title = [[[NSString alloc]initWithFormat:@"%@ %@", 
                       NSLocalizedString(@"Library", nil),
                       m_locationName] retain];

    // Set the street format
    NSString *format = @"%@ %@";
    NSString *streetType = [Address streetDescriptionFromType:m_address.streetType];
    NSString *direction = [Address streetDirectionDescription:m_address.direction];
    if(streetType)
        format = [format stringByAppendingFormat:@" %@", streetType];
    if(direction)
        format = [format stringByAppendingFormat:@" %@", direction];
    NSString *subtitle = [[[NSString alloc] initWithFormat:format,
                             m_address.streetNumber, m_address.streetName] retain];
    
    
    LocationAnnotation *locationAnnotation = [[LocationAnnotation alloc] initWithTitle:title 
                                                                              subTitle:subtitle 
                                                                           coordinates:coordinates];
    
    [title release];
    // Set the region  and the map
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationAnnotation.coordinate, 
                                                                   0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [m_mapView regionThatFits:region];                
    [m_mapView addAnnotation:locationAnnotation];
    [m_mapView  setRegion:adjustedRegion animated:TRUE];
    [m_mapView  regionThatFits:region];    
}

-(void) showErrorMessage
{
    [ErrorDialogHandler showDialogForErrorMessage:
                        NSLocalizedString(@"LOCATION DATA UNAVAILABLE", nil)];
}

@end
