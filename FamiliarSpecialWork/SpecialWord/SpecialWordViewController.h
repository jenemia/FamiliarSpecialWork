//
//  SpecialWordViewController.h
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 7..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBAdapter;
@interface SpecialWordViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIScrollView* mScrollView;
@property (nonatomic) NSInteger mCountView;
@property (strong, nonatomic) UITextField* mTextField;
@property (strong, nonatomic) UILabel* mLabel;
@property (strong, nonatomic) UIButton* mButtonBack;
@property (strong, nonatomic) UIButton* mButtonCopy;
@property (strong, nonatomic) UIButton* mButtonClear;
@property (strong, nonatomic) UIButton* mButtonDel;

- (id)init;
@property (strong, nonatomic) DBAdapter* mDBAdater;
+(void)SetCon:(NSString*)con;
@end
