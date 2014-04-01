//
//  octa_routes_vc.h
//  massTransit
//
//  Created by Christina Francis on 11/7/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "transit_data.h"
#import "octa_stops_vc.h"

@interface octa_routes_vc : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property transit_data* tr;
@end
