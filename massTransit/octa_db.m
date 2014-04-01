//
//  octa_db.m
//  massTransit
//
//  Created by Christina Francis on 11/6/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "octa_db.h"

@implementation octa_db


static octa_db* _databaseObj;

+ (octa_db*) database
{
    if (_databaseObj == nil) {
        _databaseObj = [[octa_db alloc] init];
    }
    return _databaseObj;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"OCTA" ofType:@"sl3"];
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
