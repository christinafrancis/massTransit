//
//  metro_stops_vc.m
//  massTransit
//
//  Created by Christina Francis on 11/9/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "metro_stops_vc.h"
#import "metro_db.h"
#import "metro_map_vc.h"

@interface metro_stops_vc ()

@end

@implementation metro_stops_vc


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
  
    NSLog(@"in view did load of metro stops");
    self.rv= [[NSArray alloc] init];
    
    self.rv = [[metro_db database ] allStops:self.tr.routes];
   
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
    self.rv= nil;
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
    return [self.rv count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    static NSString *MyIdentifier = @"MyCellIdentifier_st";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    transit_data *tr1 = [self.rv objectAtIndex: indexPath.row];
    
    
    NSLog(@"%@ is tr",tr1.stops);
    cell.textLabel.text = tr1.stops;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f STOP ID",tr1.stop_id];
    
    
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
  
    NSLog(@"prepareForSegue inside stops:");
    if ([segue.identifier isEqualToString:@"metro_s_map"]){
        metro_map_vc* detailVC = segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        detailVC.tr = [self.rv objectAtIndex:selectedRowIndex.row];
        detailVC.view = detailVC.times;
    }
}

#pragma mark - Back button
// method on pressing back button:
-(void) viewWillDisappear:(BOOL)animated {
    NSLog(@"inside view will disappear");
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        
         NSLog(@"inside view will disappear- if");
    }
    [super viewWillDisappear:animated];
}
@end