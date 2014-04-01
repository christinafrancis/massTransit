//
//  transit_data.h
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface transit_data : NSObject

@property  CLLocationCoordinate2D coord;
@property NSString* routes;
@property NSString* stops;
@property NSString* available_days;
@property double stop_id;
@property NSArray *earlier_times;
@property NSArray *later_times;

+ (transit_data*) dataObj;

- ( transit_data* ) initWithRoutes:(NSString*) rt withAvailableDates:(NSString*) dt;
- ( transit_data* ) initWithStops:(NSString*) st withStop_id:(double) st_id withCoord:(CLLocationCoordinate2D)cd;
- ( transit_data* )  initWithEarlyTimes:(NSArray* )early withLateTimes:(NSArray* )late withCoord:(CLLocationCoordinate2D)cd;

@end
