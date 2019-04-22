//
//  DBBaseModel.h
//  AccountManager
//
//  Created by fengweiru on 2018/7/16.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DBColumnName          @"columnName"
#define DBColumnType          @"columnType"
#define DBColumnValue         @"columnValue"
#define DBColumnIndex         @"columnIndex"
#define DBColumnPrimary       @"columnPrimary"

#define DB_TYPE_INTEGER           @"INTEGER"
#define DB_TYPE_FLOAT             @"FLOAT"
#define DB_TYPE_TEXT              @"TEXT"
#define DB_TYPE_BOOLEAN           @"BOOLEAN"
#define DB_TYPE_DATE              @"DATE"
#define DB_TYPE_BLOB              @"BLOB"
#define DB_TYPE_DOUBLE            @"DOUBLE"
#define DB_TYPE_SMALLINT          @"SMALLINT"

@protocol DataBaseModelProtocol

- (NSString *_Nullable)getTableName;
- (NSSet *_Nullable)configureCreateSet;

@end

@interface DBBaseModel : NSObject<DataBaseModelProtocol>

- (BOOL)mapDataWithJson:(id _Nullable )json;
- (BOOL)mapDataWithDictionary:(NSDictionary *_Nullable)dict;
- (NSString *_Nullable )getJsonStringWithData;
- (NSDictionary *_Nullable)getDictionaryWithData;

@end
