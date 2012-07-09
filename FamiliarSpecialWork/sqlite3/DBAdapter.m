//
//  DBAdapter.m
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "DBAdapter.h"

@implementation DBAdapter

@synthesize mFilePath;
@synthesize mFileManage;

-(id)init
{
    self = [super init];
    if( self )
    {
        [self initDB];
    }
    return self;
}

#pragma mark Add Method
-(void)initDB
{
    //document directory path 구하기
    NSString* _documentDirectory = [NSSearchPathForDirectoriesInDomains
                                    (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //document path에 *.sqlite 파일 생성
    mFilePath = [_documentDirectory stringByAppendingPathComponent:@"FamiliarSpecialWord.sqlite"];
    
    //file존재 하면 return;
    mFileManage = [NSFileManager defaultManager];
    if( [mFileManage fileExistsAtPath:mFilePath] )
    {
        NSLog(@"%@파일 존재",@"FamiliarSpecialWord.sqlite");
        
        // DB 특수문자 넣기
//         
//        NSString* word = [[NSString alloc]initWithFormat:@"%@", @"　	！	＇	，	．	／	：	；	？	＾	＿	｀	｜	￣	、	。	·	‥	…	¨	〃		―	∥	＼	∼	´	～	ˇ	˘	˝	˚	˙	¸	˛	¡	¿	ː			"	];
//        NSString* con = [[NSString alloc]initWithFormat:@"%@", @"ㄱ"];
//        
//        NSArray* sepa = [word componentsSeparatedByString:@"	"];
//        
//        for( NSString* _temp in sepa )
//        {
//            if( ![_temp isEqualToString:@"	"] )
//            {
//                [self InsertToDB:con word:_temp];
//            }   
//        }
              
        return;   
    }
    NSLog(@"%@ success", @"FamiliarSpecialWord.sqlite");
    
    sqlite3* _database;
    if( sqlite3_open( [mFilePath UTF8String], &_database) != SQLITE_OK )
    {
        //database open 못 했을 때
        sqlite3_close(_database);
        NSLog(@"Sqlite database error");
        return;
    }
    NSLog(@"Sqlite database success");
    
    sqlite3_close(_database);
}

-(NSMutableArray*)SelectToConsonant
{
    sqlite3* _database;
    if( sqlite3_open( [mFilePath UTF8String], &_database) != SQLITE_OK )
    {
        //database open 못 했을 때
        sqlite3_close(_database);
        NSLog(@"Sqlite database error");
        return nil;
    }
    NSLog(@"Sqlite database success");
    
    sqlite3_stmt* _statement;
    char* _sql = "SELECT key FROM consonant";
    NSMutableArray* _result = [[NSMutableArray alloc]init];
    
    if( sqlite3_prepare_v2(_database, _sql, -1, &_statement, NULL) == SQLITE_OK )
    {
        while( sqlite3_step(_statement) == SQLITE_ROW )
        {
            [_result addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(_statement, 0)]];
        }
    }
    else {
        return nil;
    }
    sqlite3_finalize(_statement);    
    sqlite3_close(_database);

    return _result;
}

-(NSMutableArray*)SelectToSpecialWord:(NSString*)con
{
    sqlite3* _database;
    if( sqlite3_open( [mFilePath UTF8String], &_database) != SQLITE_OK )
    {
        //database open 못 했을 때
        sqlite3_close(_database);
        NSLog(@"Sqlite database error");
        return nil;
    }
    NSLog(@"Sqlite database success");
    
    sqlite3_stmt* _statement;
    NSString* sql = [[NSString alloc]initWithFormat:
                   @"select word from (select * from SpecialWord where con = '%@')", con];
    const char* _sql = [sql UTF8String];
    NSMutableArray* _result = [[NSMutableArray alloc]init];
    
    if( sqlite3_prepare_v2(_database, _sql, -1, &_statement, NULL) == SQLITE_OK )
    {
        while( sqlite3_step(_statement) == SQLITE_ROW )
        {
            [_result addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(_statement, 0)]];
        }
    }
    else {
        return nil;
    }
    sqlite3_finalize(_statement);    
    sqlite3_close(_database);
    
    return _result;
}

-(void)InsertToDB:(NSString*)con word:(NSString*)word
{
    sqlite3* _database;
    if( sqlite3_open( [mFilePath UTF8String], &_database) != SQLITE_OK )
    {
        //database open 못 했을 때
        sqlite3_close(_database);
        NSLog(@"Sqlite database error");
        return;
    }
    NSLog(@"Sqlite database success");
    
    sqlite3_stmt* _statement;
    NSString* sql = [[NSString alloc]initWithFormat:@"INSERT INTO SpecialWord (con, word) VALUES ("];
    sql = [sql stringByAppendingFormat:@"'%@', ",con];
    sql = [sql stringByAppendingFormat:@"'%@' );", word];
    const char* _sql = [sql UTF8String];
    
    if( sqlite3_prepare_v2(_database, _sql, -1, &_statement, NULL) == SQLITE_OK )
    {
        if( sqlite3_step(_statement) != SQLITE_DONE )
            NSLog(@"Step error");
    }
    sqlite3_finalize(_statement);    
    sqlite3_close(_database);
}
@end
