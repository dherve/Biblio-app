//
//  LibraryDetailsViewController.m
//  Biblios
//

#import "LibraryDetailsViewController.h"
#import "UIStyles.h"
#import "LibraryDetailsCell.h"
#import "BusinessHoursCell.h"
#import "MapViewController.h"
#import "Address.h"
#import "DirectionsWebViewController.h"
#import "Utilis.h"
@implementation LibraryDetailsViewController
-(id) initWithLibrary:(Library *) library
{
    self = [super init];
    if(self != nil)
    {
        m_library = library;
        m_directionsHandler = [[DirectionsHandler alloc] initWithDestination:library.address];
        m_sectionData = [[NSMutableDictionary alloc] init];
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
    [m_directionsHandler release];
    [m_library release];
    [super dealloc];
}
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // Set the title
    m_viewTitle = NSLocalizedString(@"Library details", 
                                    @"Title for the library details screen");
    
    // Set header
    m_header = [[BaseHeader alloc]initWithFrame:CGRectMake(0, 0,HEADER_WIDTH,
                                                           HEADER_HEIGHT)];
    [m_header setTextContent:m_library.name 
                     subText:NSLocalizedString(@"Library", 
                                               @"Title for the library details screen")];
       


    // set the sections
    m_sections = [[NSMutableArray alloc] init];
                  
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];

    
    
    // Adress
    Address *address = m_library.address;
    NSString *format = @"%@ %@";
    NSString *streetType = [Address streetDescriptionFromType:address.streetType];
    NSString *direction = [Address streetDirectionDescription:address.direction];
    
    // Set the formating for the street.
    if(streetType)
        format = [format stringByAppendingFormat:@" %@", streetType];
    if(direction)
        format = [format stringByAppendingFormat:@" %@", direction];
    NSString *adressLine1 = [NSString stringWithFormat:format,
                             address.streetNumber, address.streetName];

    NSString *adressLine2 = [NSString stringWithFormat:@"%@ (%@) %@",
                             address.city, address.province, address.zipCode];
    
    [coordinates addObject:[NSArray arrayWithObjects:adressLine1, adressLine2,nil]];
    
    // Telepone number(s)
    if(![m_library.adultSectionPhone isEqualToString:@"nil"] &&  
       ![m_library.youthSectionPhone isEqualToString:@"nil"])
    {
        
        [coordinates addObject:[NSArray arrayWithObjects:m_library.adultSectionPhone, 
                            m_library.youthSectionPhone,nil]];
    }
    else
    {
        [coordinates addObject:[NSArray arrayWithObjects:m_library.generalPhone,@"", nil]];
    }
    
    [coordinates addObject:[NSArray arrayWithObjects:
                            NSLocalizedString(@"Directions", @""), 
                            @"", nil]];
    [m_sectionData setValue:coordinates forKey:SECTION_FULL_ADDRESS];
    [m_sections addObject:SECTION_FULL_ADDRESS];

    // Business hours
    [m_sectionData setValue:m_library.businessHours forKey:SECTION_BUSINESS_HOURS];
    [m_sections addObject:SECTION_BUSINESS_HOURS];
    
    [super loadView];
    
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_directionsHandler startMonitoringUserLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [m_directionsHandler stopMonitoringUserLocation];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [m_sections objectAtIndex:section];
    if([title isEqualToString:SECTION_BUSINESS_HOURS])
        return title;
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell;
    NSString *CellIdentifier = @"";
    // Get the section and data
    NSString *section = [m_sections objectAtIndex:indexPath.section];
    NSMutableArray *sectionData = [m_sectionData objectForKey:section];
    
    // Create and set the appropriate cell depending of the current section.
    if([section isEqualToString:SECTION_FULL_ADDRESS] == YES)
    {
        CellIdentifier = @"LibraryDetailsCell";
        
        cell = (LibraryDetailsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[LibraryDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                              reuseIdentifier:CellIdentifier] autorelease];
        }        
        
        // Get the data for this cell.
        NSArray *cellData = [sectionData objectAtIndex:indexPath.row];
        
        // Set the cell text content.
        [cell setTextLines:[cellData objectAtIndex:0] 
            secondLineText:[cellData objectAtIndex:1]];
        
        // Set the icon to be shown depending of the information ot be shown
        // in the cell.
        switch (indexPath.row) {
            case 0:[cell setIconImage: [UIImage imageNamed:IMG_LIBRARY_ICON]];
                break;
                
            case 1:[cell setIconImage: [UIImage imageNamed:IMG_PHONE_ICON]];
                break;
                
            case 2:[cell setIconImage: [UIImage imageNamed:IMG_COMPASS_ICON]];
                break;
            default:[cell setIconImage: [UIImage imageNamed:IMG_ICON_HOLDER]];
                break;
        }
        
    }
    else if([section isEqualToString:SECTION_BUSINESS_HOURS] == YES)
    {
        CellIdentifier = @"BusinessHoursCell";
        
        cell = (BusinessHoursCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[BusinessHoursCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                              reuseIdentifier:CellIdentifier] autorelease];
        }  
        
        // Which row (day) is to be shown.
        NSInteger row = indexPath.row;
        
        // Here we add one to the row value, since the row value start at 0
        // while the day values start with 1.
        NSString *day = [Utilis dayFromNumericValue:row + 1];
        [cell setTime:day openHours:[sectionData objectAtIndex:row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *section = [m_sections objectAtIndex:indexPath.section];
    return [section isEqualToString:SECTION_FULL_ADDRESS] ? CUSTOM_CELL_HEIGHT :
                                                            BUSINESS_HOURS_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [m_sections objectAtIndex:section];
    
    //The title for business hours section only
    if([title isEqualToString:SECTION_BUSINESS_HOURS])
    {
        // View to hold the title label
        UIView *view = [[UIView alloc] initWithFrame:
                        CGRectMake(VIEW_LEFT_MARGINS + CELL_PADDING_LEFT,0, 
                                   CUSTOM_CELL_WIDTH, BUSINESS_HOURS_CELL_HEIGHT)];
        [view setBackgroundColor:[UIColor clearColor]];
        
        // label title
        UILabel *label = [UIStyles customLabel:VIEW_LEFT_MARGINS
                                             y:0 
                                         width:CUSTOM_CELL_WIDTH
                                        height:BUSINESS_HOURS_CELL_HEIGHT 
                                          font:CONTENT_FONT];
        [label setText:title];
        [view addSubview:label];
        return view;
    }
    return nil; 
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *title = [m_sections objectAtIndex:section];
    if([title isEqualToString:SECTION_BUSINESS_HOURS])
    {
       return BUSINESS_HOURS_CELL_HEIGHT;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *section = [m_sections objectAtIndex:indexPath.section];
    id viewToPush;
    if(section == SECTION_FULL_ADDRESS)
    {
        switch (indexPath.row) {
            // Address -> push the map view    
            case 0:
            {
                m_library.address.locationName = m_library.name;
                viewToPush = [[MapViewController alloc] initWithLocation:m_library.address 
                                                            locationName:m_library.name];
                
            }
                break;
            // Tel -> prompt the window to call
            case 1: 
                // if there are two address ask the user which one he wants to call
                // Chekcif we can make a call 
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:514-559-6153"]];
                // invoque phone API 
                return;
                
            // Directions ->push directions controller
            case 2 :
            {
                viewToPush = [[DirectionsWebViewController alloc] initWithDestination:m_library.address];
                
            }
            break;
                
            default:
                break;
        }
        [self.navigationController pushViewController:viewToPush animated:YES];
        [viewToPush release];
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    }
     
}

@end
