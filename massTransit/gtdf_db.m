//
//  gtdf_db.m
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "transit_data.h"
#import "gtdf_db.h"
#import <sqlite3.h>

@implementation gtdf_db


- (NSArray*) routes
{
    NSMutableArray* rv = [[NSMutableArray alloc] init];
    NSString* query = @"SELECT  a.route_long_name b.stop_id FROM routes a, stops b ;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *country, *city;
 
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if( text )
                country = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                country = nil;
            text = sqlite3_column_text(stmt, 1);
            if(text)
                city = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                city = nil;
            
            [rv addObject: country];
        }
        sqlite3_finalize(stmt);
    }
    return rv;
}

-(NSInteger ) getWeekday{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    //NSInteger day = [weekdayComponents day];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday;
}
-(NSString *) getTime{
    NSDate *today = [[NSDate alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [dateFormatter stringFromDate:today];
    
    return timeString;
}

-(BOOL) isTimeEarly:(NSString* )tm{
    
   
    switch ([tm compare:[self getTime]]){
        case NSOrderedAscending:
            return YES;
            
        case NSOrderedSame:
            return YES;
           
        case NSOrderedDescending:
            return NO;
           
        }
}

- (NSArray*) allStops:(NSString* ) route{
    [self getTime];
    
    NSMutableArray* rv = [[NSMutableArray alloc] init];
    NSString* query = [NSString stringWithFormat:@"SELECT distinct a.stop_name, a.stop_id,a.stop_lon, a.stop_lat FROM stops a ,routes b,trips c, stop_times d where b.route_long_name = \"%@\" and c.route_id = b.route_id and c.trip_id = d.trip_id and a.stop_id = d.stop_id order by a.stop_name;", route];
    sqlite3_stmt *stmt;
    NSString *stops;
    double st_id;
    double longitude;
    double latitude;
    
    const unsigned char* text;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        
        while( sqlite3_step(stmt) == SQLITE_ROW){
            
            
            text = sqlite3_column_text(stmt, 0);
            if( text )
                stops = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                stops = nil;
            
            st_id = sqlite3_column_double(stmt, 1);
            
            
            longitude = sqlite3_column_double(stmt, 2);
            latitude = sqlite3_column_double(stmt, 3);
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
            
            
           
            transit_data* tr = [[transit_data alloc] initWithStops:stops withStop_id:st_id withCoord:coord];
            [rv addObject: tr];
            
        }
        
        sqlite3_finalize(stmt);
    }
    
    return rv;
}

- (NSArray*) allTimes:(double) st_id withCoord:(CLLocationCoordinate2D) coord
{
    
    NSMutableArray* rv = [[NSMutableArray alloc] init];
    NSString* query = [NSString stringWithFormat: @"SELECT distinct a.arrival_time from stop_times a where stop_id = %.0f order by a.arrival_time; ",st_id ];
    NSLog(@"%@ is query",query);
    sqlite3_stmt *stmt;
    NSMutableArray *early = [[NSMutableArray alloc] init];
    NSMutableArray *late = [[NSMutableArray alloc] init];
    NSString *tm;
    
    
    const unsigned char* text;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        
        while( sqlite3_step(stmt) == SQLITE_ROW){
           
            
            text = sqlite3_column_text(stmt, 0);
            if( text ){
                
               tm = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            if([self isTimeEarly:tm]){
                [early addObject:tm];
            }
            else
                [late addObject:tm];
           }
            
           
            transit_data* tr = [[transit_data alloc] initWithEarlyTimes:early withLateTimes:late withCoord:coord];
            [rv addObject: tr];
            
            
        }
        
        sqlite3_finalize(stmt);
    }
    
    return rv;
}

- (NSArray*) allRoutes
{
    [self getTime];
    
    NSMutableArray* rv = [[NSMutableArray alloc] init];
    NSString* query = @"SELECT distinct a.route_long_name, b.service_id FROM routes a, trips b where a.route_id = b.route_id  order by a.route_long_name;";
    sqlite3_stmt *stmt;
    NSString *routes;
    NSString *dts;
    const unsigned char* text;
 
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        
        while( sqlite3_step(stmt) == SQLITE_ROW){
         
            
            text = sqlite3_column_text(stmt, 0);
            if( text )
                routes = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routes = nil;
            text = sqlite3_column_text(stmt, 1);
            if(text)
                dts = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                dts = nil;
           
            
            transit_data* tr = [[transit_data alloc] initWithRoutes:routes withAvailableDates:dts];
             [rv addObject: tr];
           
            }
        
        sqlite3_finalize(stmt);
    }

    return rv;
}
@end
