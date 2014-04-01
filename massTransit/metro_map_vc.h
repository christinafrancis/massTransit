//
//  metro_map_vc.h
//  massTransit
//
//  Created by Christina Francis on 11/10/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "transit_data.h"

@interface metro_map_vc : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *times;
@property NSArray *earlier_times;
@property NSArray *later_times;
@property transit_data* tr;


@end

