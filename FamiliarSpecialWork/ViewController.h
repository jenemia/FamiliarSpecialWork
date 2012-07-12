//
//  ViewController.h
//  FamiliarSpecialWork
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBAdapter;
@class SpecialWordViewController;

@interface ViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) UITextField* mTextField;

//다른 View로 넘어가는 Button
@property (strong, nonatomic) UIButton* mButtonKatok;
@property (strong, nonatomic) UIButton* mButtonEmoticonAdd;
@property (strong, nonatomic) UIButton* mButtonEmoticonCollection;
@property (strong, nonatomic) UIButton* mButtonEmoticonMine;
@property (strong, nonatomic) UIButton* mButtonEmoticonBookmark;

//특수문자가 있는 View로 넘어가는 Button을 넣기 위한 Array
@property (strong, nonatomic) NSMutableArray* mArrayButton;
//DB 연결 객체
@property (strong, nonatomic) DBAdapter* mDBAdater;
//특수문자 연결 ViewController 객체
@property (strong, nonatomic) SpecialWordViewController* mSpecialWord;

//Button을 생성하는 Method.
-(UIButton*)CreateButton:(NSString *)title type:(UIButtonType)type 
                   frame:(CGRect)frame target:(id)target action:(SEL)action img:(NSString*)img;
@end
