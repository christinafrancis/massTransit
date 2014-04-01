//
//  metro_db.m
//  massTransit
//
//  Created by Christina Francis on 11/6/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "metro_db.h"

@implementation metro_db


static metro_db* _databaseObj;

+ (metro_db*) database
{
    if (_databaseObj == nil) {
        _databaseObj = [[metro_db alloc] init];
    }
    return _databaseObj;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"Metrolink" ofType:@"sl3"];
        if (sqlite3_open([dbpath UTF8String], &_databaseConnection) != SQLITE_OK) {
            NSLog(@"Failed to open database.");
        }
    }
    return self;
}

- (void) dealloc
{
    sqlite3_close(_databaseConnection);
}


@end
