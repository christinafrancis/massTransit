//
//  gtdf_db.h
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>

@interface gtdf_db : NSObject
{
     sqlite3* _databaseConnection;
}

- (NSArray*) routes;
- (NSArray*) allRoutes;
- (NSArray*) allStops:(NSString* ) route;
- (NSArray*) allTimes:(double) st_id withCoord:(CLLocationCoordinate2D) coord;

//- (NSArray*) stops;
//- (NSArray*) stopsNow;

@end
