//
//  ViewController.m
//  FamiliarSpecialWork
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DBAdapter.h"
#import "SpecialWordViewController.h"
#import "KakaoLinkCenter.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize mTextField;

@synthesize mButtonKatok;
@synthesize mArrayButton;
@synthesize mDBAdater;
@synthesize mSpecialWord;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //디비 있으면, 디비 데이터 있으면, 그걸로 초기화     
    mDBAdater = [AppDelegate sharedDBAdapter];
    mSpecialWord = [AppDelegate shareSpeciaWord];
    
//	[self.view setBackgroundColor:[UIColor yellowColor]]; //다른 object들이 보이도록 임시로 view를 노란색으로.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    mTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 31)];
    mTextField.borderStyle = UITextBorderStyleRoundedRect; //모서리 부분을 둥글게
    [mTextField setBackgroundColor:[UIColor whiteColor]];
    mTextField.delegate = self;
    
    [self.view addSubview:mTextField];
    
    mButtonKatok = [self CreateButton:@"카톡 보내기" type:UIButtonTypeRoundedRect 
                                frame:CGRectMake(10, 95, 85, 37) target:self 
                               action:@selector(KakaotokButton) img:@""];
    
    [self.view addSubview:mButtonKatok];
    
    NSMutableArray* _array = [mDBAdater SelectToConsonant];//DB에서 자음들을 가져온다.
    
    mArrayButton = [NSMutableArray array];
    NSInteger _cnt = 18;
    CGFloat _width = 60;
    int _num = 0;
    CGFloat _x = 0, _y=0;
    NSString* _str = [[NSString alloc]init];

    for( NSInteger i=0; i<_cnt; i++ )
    {
        _x = 20 + (i/5)*10; //2번 째 줄은 x좌표가 10만큼 더, 3번 째 줄은 20만큼 더.
        _y = 155 + (i/5)*55;
        
        if( 14 == i )
            _num = 0;
        
        if( 14 <= i )
        {
            _x = 20;
            _y = 155 + (16/5)*55;
        }

        if( nil != _array ) //자음이 있을 때 _str네 넣는다.
            _str = [_array objectAtIndex:i];
        UIButton* _btn = [self CreateButton:_str type:UIButtonTypeRoundedRect 
                                      frame:CGRectMake(_x + _width*_num, _y, 40, 40) target:self action:@selector(ButtonClick:) img:@""];
        _btn.titleLabel.font = [UIFont systemFontOfSize:30];
        [mArrayButton addObject: _btn];
        _num++;
        if( 0 == (_num%5) )
            _num = 0;
  
    }
    
    for( UIButton* _button in mArrayButton )
    {
        [self.view addSubview:_button];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)viewWillAppear:(BOOL)animated
{   
    //싱글톤 객체 배열에 있는 문자열로 초기화. 혹여 문자가 안맞을 수 도 있으니.
    mTextField.text = @"";
    for( NSString* tmp in [AppDelegate shareWordArray] )
    {
        mTextField.text = [mTextField.text stringByAppendingFormat:tmp];
    }
    
    [super viewWillAppear:YES];
}


#pragma mark CreateMethod
/*    
 Button생성시 필요한 것들을 모아 Method로 만든 것.
 title : Button에 보이는 문자열
 type : Button의 생김새
 frame : Button의 위치 및 크기
 target : Button의 event를 처리할 부분을 설정하는 곳. self면 현재 소스파일에서 처리한다는 것.
 action : Button evnetf를 처리할 method. 여기선 Click Event
 img : Background에 그릴 Image
 */
-(UIButton*)CreateButton:(NSString *)title type:(UIButtonType)type frame:(CGRect)frame target:(id)target action:(SEL)action img:(NSString *)img
{
    UIButton* button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if( img != @"" )
    {
        UIImage* _img = [UIImage imageNamed:img];
        [button setBackgroundImage:_img forState:UIControlStateNormal];
    }
    return button;
}

-(void)ButtonClick:(id)sender
{
    NSString* _con = [[NSString alloc]initWithFormat:((UIButton*)sender).titleLabel.text];
    [SpecialWordViewController SetCon:_con];
    [self presentModalViewController:mSpecialWord animated:YES];
}

-(void)KakaotokButton
{
    NSString *message = mTextField.text;
    NSString *referenceURLString = @"";
    NSString *appBundleID = @"com.jenemia.SpecialWord";
    NSString *appVersion = @"2.0";
    NSString *appName = @"";
    
    if ([[KakaoLinkCenter defaultCenter] canOpenKakaoLink]) {
        [[KakaoLinkCenter defaultCenter] openKakaoLinkWithURL:referenceURLString 
                                                   appVersion:appVersion
                                                  appBundleID:appBundleID
                                                      appName:appName
                                                      message:message];
    } else {
        NSLog(@"카톡이없네요");
    }
}

#pragma mark TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}
@end
