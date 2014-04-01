//
//  metro_stops_vc.h
//  massTransit
//
//  Created by Christina Francis on 11/9/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "transit_data.h"


@interface metro_stops_vc :  UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property transit_data* tr;
@property NSArray *rv;
@end
