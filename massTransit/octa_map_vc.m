

//
//  octa_map_vc.m
//  massTransit
//
//  Created by Christina Francis on 11/10/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "octa_map_vc.h"
#import "octa_db.h"


@interface octa_map_vc ()

@end

@implementation octa_map_vc


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        
        return [self.tr.earlier_times count];
    }
    else{
        return [self.tr.later_times count];
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    if (section == 0)
        return @"Earlier times";
    else if (section == 1)
        return @"later times";
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray* time_comps;
    NSString* time_string;
    NSString* hh;
    NSString* mm;
    static NSString *MyIdentifier = @"MyCellIdentifier_mp";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }

    
    switch (indexPath.section) {
        case 0:
            
    
            time_string = [self.tr.earlier_times objectAtIndex:indexPath.row] ;
            time_comps = [time_string componentsSeparatedByString:@":"];
            hh = [time_comps objectAtIndex:0];
            mm = [time_comps objectAtIndex:1];
            if ( [hh floatValue] < 12) {
                time_string = [NSString stringWithFormat:@"%.0f : %@  AM", [hh floatValue],mm];
            }
            else if( [hh floatValue] == 12.0) {
                time_string = [NSString stringWithFormat:@"%@ : %@  PM", hh,mm];
            }
            else
            time_string = [NSString stringWithFormat:@"%.0f : %@  PM", [hh floatValue] - 12,mm];
            
            cell.textLabel.text=time_string;
            break;
        case 1:
            time_string = [self.tr.later_times objectAtIndex:indexPath.row] ;
            time_comps = [time_string componentsSeparatedByString:@":"];
            hh = [time_comps objectAtIndex:0];
            mm = [time_comps objectAtIndex:1];
            if ( [hh floatValue] < 12) {
                time_string = [NSString stringWithFormat:@"%0.0f : %@  AM", [hh floatValue] ,mm];
            }
            else if( [hh floatValue] == 12.0) {
                time_string = [NSString stringWithFormat:@"%@ : %@  PM", hh,mm];
            }
            else
                time_string = [NSString stringWithFormat:@"%.0f : %@  PM", [hh floatValue] - 12,mm];
            
            cell.textLabel.text=time_string;
            break;
      
        default:
            break;
    }
    
    
    
    
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *rv= [[NSArray alloc] init];
    
    rv = [[octa_db database ] allTimes:self.tr.stop_id withCoord:self.tr.coord];
    self.tr = [rv objectAtIndex:[rv count] - 1];
    NSLog(@"%f is lat, %f is lon", self.tr.coord.longitude,self.tr.coord.latitude);
	// Do any additional setup after loading the view.
    [self.map setCenterCoordinate: self.tr.coord animated: YES];
    self.map.region = MKCoordinateRegionMake(self.tr.coord, MKCoordinateSpanMake(0.5, 0.5));
   MKPointAnnotation * avoid_dealloc_while_reg;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    avoid_dealloc_while_reg = annotation;
    [annotation setCoordinate: self.tr.coord];
    [annotation setTitle: self.tr.stops];
    [self.map addAnnotation:annotation];
    
    //UITableView *tableView = self.times;
    //tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.times.delegate = self;
    self.times.dataSource = self;
    [self.times reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

