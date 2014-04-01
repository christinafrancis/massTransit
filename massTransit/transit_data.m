//
//  transit_data.m
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "transit_data.h"

@implementation transit_data


static transit_data* _dataObj;

+ (transit_data*) dataObj
{
    if (_dataObj == nil) {
        _dataObj = [[transit_data alloc] init];
    }
    return _dataObj;
}

- ( transit_data* ) initWithRoutes:(NSString*) rt withAvailableDates:(NSString*) dt{
    self = [super init];
    if( self ){
        self.routes = [NSString stringWithString: rt];
        self.available_days = [NSString stringWithString: dt];
    }
    return self;
}

- ( transit_data* ) initWithStops:(NSString*) st withStop_id:(double)st_id withCoord:(CLLocationCoordinate2D)cd{
    self = [super init];
    if( self ){
        self.stops = [NSString stringWithString: st];
        self.stop_id = st_id;
        self.coord = CLLocationCoordinate2DMake(cd.latitude, cd.longitude);
    }
    return self;
}

- ( transit_data* )  initWithEarlyTimes:(NSArray *)early withLateTimes:(NSArray *)late withCoord:(CLLocationCoordinate2D)cd{
    self = [super init];
    if( self ){
        self.earlier_times =  [NSArray arrayWithArray: early];
        self.later_times = [NSArray arrayWithArray: late ];
        self.coord = CLLocationCoordinate2DMake(cd.latitude, cd.longitude);
    }
    return self;
}
@end
