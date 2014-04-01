//
//  octa_db.h
//  massTransit
//
//  Created by Christina Francis on 11/6/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gtdf_db.h"

@interface octa_db  : gtdf_db

{
    //sqlite3* _databaseConnection;
}

+ (octa_db*) database;

@end
