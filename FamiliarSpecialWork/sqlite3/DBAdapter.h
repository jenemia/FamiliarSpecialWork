//
//  DBAdapter.h
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBAdapter : NSObject

@property (strong, nonatomic) NSString* mFilePath;
@property (strong, nonatomic) NSFileManager* mFileManage;

-(id)init;
-(void)initDB;
-(NSMutableArray*)SelectToConsonant;

@end
