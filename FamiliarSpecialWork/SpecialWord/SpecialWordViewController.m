//
//  SpecialWordViewController.m
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 7..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "SpecialWordViewController.h"
#import "AppDelegate.h"
#import "DBAdapter.h"

@interface SpecialWordViewController ()

@end

@implementation SpecialWordViewController

@synthesize mScrollView;
@synthesize mDBAdater;
@synthesize mCountView;
@synthesize mLabel, mTextField;
@synthesize mButtonBack, mButtonClear, mButtonCopy, mButtonDel;

static NSString* g_Con;

- (id)init{
    self = [super init];
    [self.view setFrame:CGRectMake(0, 0, 320, 460)];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor yellowColor]];   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    mDBAdater = [AppDelegate sharedDBAdapter];
    
	// Do any additional setup after loading the view.    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 145, 320, 235)];

    mScrollView.pagingEnabled = YES; //스크롤 할때 페이지 마다 툭툭 끊키게
    [self.view addSubview:mScrollView];
    
    mTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 50, 320, 31)];
    mTextField.borderStyle = UITextBorderStyleRoundedRect; //모서리 부분을 둥글게
    //mTextField.backgroundColor = [UIColor whiteColor];
    mTextField.text = @"";
    mTextField.delegate = self;
    mTextField.font = [UIFont fontWithName:@"Apple SD Gothic Neo" size:15];
    [self.view addSubview:mTextField];
    
    mLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 70, 80, 80)];
    [self.view addSubview:mLabel];
    [mLabel setFont:[UIFont systemFontOfSize:90]];
    mLabel.backgroundColor = [UIColor clearColor];
    
    mButtonBack = [self CreateButton:@"Back" type:UIButtonTypeRoundedRect 
                               frame:CGRectMake(20, 390, 50, 40) target:self action:@selector(BackButton) img:@""];
    mButtonCopy = [self CreateButton:@"All Copy" type:UIButtonTypeRoundedRect 
                              frame:CGRectMake(80, 390, 105, 40) target:self action:@selector(CopyButton) img:@""];
    mButtonClear = [self CreateButton:@"Clear" type:UIButtonTypeRoundedRect 
                             frame:CGRectMake(195, 390, 50, 40) target:self action:@selector(ClearButton) img:@""];
    mButtonDel = [self CreateButton:@"Del" type:UIButtonTypeRoundedRect 
                              frame:CGRectMake(255, 390, 50, 40) target:self action:@selector(DelButton) img:@""];
    [self.view addSubview:mButtonBack];
    [self.view addSubview:mButtonCopy];
    [self.view addSubview:mButtonClear];
    [self.view addSubview:mButtonDel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{   
    //mScrollView에 기존에 있던 subView들을 삭제.
    for( UIView* temp in mScrollView.subviews )
    {
        [temp removeFromSuperview];
    }
    
    //싱글톤 객체 배열에 있는 문자열로 초기화. 혹여 문자가 안맞을 수 도 있으니.
    mTextField.text = @"";
    for( NSString* tmp in [AppDelegate shareWordArray] )
    {
        mTextField.text = [mTextField.text stringByAppendingFormat:tmp];
    }
    
    //자음을 표시하는 Label의 text를 현재 입력된 자음으로 
    mLabel.text = g_Con;
    [mLabel setFont:[UIFont systemFontOfSize:90]];
    
    //DB에서 특수 문자를 가져온다.
    NSMutableArray* _array = [mDBAdater SelectToSpecialWord:g_Con];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 235)];
    
    //특수문자들을 하나의 view에 5칸 4줄로 만든다. 
    NSInteger _ViewCnt = 0;
    NSInteger _XCnt = 0;
    NSInteger _YCnt = 0;
    for( NSString* _str in _array )
    {
        CGFloat _x = 20 + 60*_XCnt;
        CGFloat _y = 5 +  60*_YCnt;
        UIButton* _button = [self CreateButton:_str type:UIButtonTypeRoundedRect 
                                         frame:CGRectMake(_x, _y, 45, 45) target:self 
                                        action:@selector(WordButton:) img:@""];
        _button.titleLabel.font = [UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
        [view addSubview:_button];
      
        _XCnt++;
        if( _XCnt == 5 ) //한 줄에 5개, 
        {
            _XCnt = 0;
            _YCnt++;
        }
        if( _YCnt == 4 ) //한 View에 4줄
        {
            [mScrollView addSubview:view];
            
            _XCnt = 0;
            _YCnt = 0;
            _ViewCnt++;
            //다음 페이지에 보여질 View 생성
            view = [[UIView alloc]initWithFrame:CGRectMake(320*_ViewCnt, 0, 320, 235)];
        }
    }
    [mScrollView addSubview:view]; //마지막 View 생성
    mScrollView.contentSize = CGSizeMake(320*(_ViewCnt+1), 235);
    
    
    AdamAdView* _adView = [AdamAdView sharedAdView];
    _adView.delegate = self;
    
    if( ![_adView.subviews isEqual:self.view] )
    {
        _adView.frame = CGRectMake(0, 0, 320, 48);
        _adView.clientId = @"1ef1Z9eT1351519af70";
        [self.view addSubview:_adView];
        
        if( !_adView.usingAutoRequest )
        {
            [_adView startAutoRequestAd:60.0];
        }
        
    }
    
    [super viewWillAppear:YES];
}

-(void)didReceiveAd:(AdamAdView *)adView
{
    NSLog(@"sucess");
}

-(void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
{
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//메인 뷰에서 자음을 누를 때 호출한다.
+(void)SetCon:(NSString *)con
{
    g_Con = [[NSString alloc]initWithFormat:con];
}

#pragma mark Method
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

-(void)WordButton:(id)sender
{
    NSString* _word = [sender titleForState:UIControlStateNormal];
    mTextField.text = [mTextField.text stringByAppendingFormat:_word]; //입력한 문자를 뒤에 붙이기
    
    [[AppDelegate shareWordArray]addObject:_word]; //싱글톤 객체 배열에 넣기.
    
    [[UIPasteboard generalPasteboard] setString:_word]; //클립보드에 넣기( 복사 )
}

-(void)BackButton
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)ClearButton
{
    mTextField.text = @"";
    [[AppDelegate shareWordArray]removeAllObjects];
}

-(void)DelButton
{
    [[AppDelegate shareWordArray]removeLastObject];
    mTextField.text = @"";
    for( NSString* tmp in [AppDelegate shareWordArray] )
    {
        mTextField.text = [mTextField.text stringByAppendingFormat:tmp];
    }
}

-(void)CopyButton
{
    [[UIPasteboard generalPasteboard] setString:mTextField.text]; 
}

#pragma mark TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [mTextField resignFirstResponder];
    return YES;
}
@end
