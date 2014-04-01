//
//  metro_routes_vc.m
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "metro_routes_vc.h"
#import "metro_db.h"


@interface metro_routes_vc ()

@end

@implementation metro_routes_vc
NSArray* rv;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    rv= [[NSArray alloc] init];

    rv = [[metro_db database ] allRoutes];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.tr = nil;
    rv= nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [rv count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    static NSString *MyIdentifier = @"MyCellIdentifier";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    transit_data *tr1 = [rv objectAtIndex: indexPath.row];
    if ([tr1.available_days isEqualToString:@"WD"]) {
        
        UIImage* anImage = [UIImage imageNamed:@"header_every_day.jpg"];
        
         [[cell imageView] setImage:anImage];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"all weekdays "];
    }
    if ([tr1.available_days isEqualToString:@"SU"]) {
        UIImage* anImage = [UIImage imageNamed:@"sun.jpeg"];

        cell.detailTextLabel.text = [NSString stringWithFormat:@"on sundays "];
                [[cell imageView] setImage:anImage];
    }
    if ([tr1.available_days isEqualToString:@"SA"]) {
        UIImage* anImage = [UIImage imageNamed:@"sat.jpeg"];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"on saturdays"];
        [[cell imageView] setImage:anImage];
    }
    
    UIImage* anImage = [UIImage imageNamed:@"metro_logo.jpeg"];
    
    [[cell imageView] setImage:anImage];
    
    NSLog(@"%@ is tr",tr1.routes);
    cell.textLabel.text = tr1.routes;
    
     
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"metro_r_s"]){
        metro_stops_vc* detailVC = segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        detailVC.tr = [rv objectAtIndex:selectedRowIndex.row];
    }
}

@end
