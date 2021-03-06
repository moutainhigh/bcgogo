//
//  KKRegisterAccountViewController.m
//  KKOBD
//
//  Created by zhuyc on 13-8-12.
//  Copyright (c) 2013年 zhuyc. All rights reserved.
//

#import "KKRegisterAccountViewController.h"
#import "UIViewController+extend.h"
#import "KKViewUtils.h"
#import "KKCustomTextField.h"
#import "KKRegisterAccount2ViewController.h"
#import "KKApplicationDefine.h"
#import "KKHelper.h"
#import "KKCustomAlertView.h"

@interface KKRegisterAccountViewController ()

@end

@implementation KKRegisterAccountViewController

#pragma mark -
#pragma mark View methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setVcEdgesForExtendedLayout];
    [self initVariables];
    [self initComponents];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self resignKeyboardNotification];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeKeyboardNotification];
}

#pragma mark -
#pragma mark Custom methods

- (void) initVariables
{
    [self initNavTitleView];
    
    self.vehicleDetail = [[[KKModelVehicleDetailInfo alloc] init] autorelease];
}

- (void) initComponents
{
    self.navigationItem.leftBarButtonItem = [KKViewUtils createNavigationBarButtonItem:[UIImage imageNamed:@"icon_back.png"] bgImage:nil target:self action:@selector(backButtonClicked)];
    
    UIImageView *bgImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,  self.view.bounds.size.height)];
    bgImv.image = [[UIImage imageNamed:@"bg_background.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    bgImv.userInteractionEnabled = YES;
    bgImv.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgImv];
    [bgImv release];
    
    NSMutableArray *nameArr = [[NSMutableArray alloc] initWithObjects:@"用户名 :",@"设置密码 :",@"确认密码 :",@"手机号 :", nil];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, currentScreenHeight - 44 - [self getOrignY])];
    [_mainScrollView setContentSize:CGSizeMake(320, currentScreenHeight - 44 - [self getOrignY])];
    _mainScrollView.userInteractionEnabled = YES;
    
    CGPoint point = CGPointMake(85, 15);
    CGPoint point2 = CGPointMake(0, 27);
    
    //添加textfield，以item的index来查看
    for (int i = 0; i < [nameArr count]; i ++) {
        KKCustomTextField *textField = [[KKCustomTextField alloc] initWithFrame:CGRectMake(point.x, point.y, 223, 38) WithType:eTextFieldNone WithPlaceholder:nil WithImage:nil WithRightInsetWidth:0];
        textField.index = 10 + i;
        textField.textField.tag = 100 + i;
        textField.textField.delegate = self;
        textField.textField.returnKeyType = UIReturnKeyDone;
        if (i == 0)
            textField.textField.placeholder = @"手机/邮箱/车牌";
        
        if (i == 1 || i == 2)
            textField.textField.secureTextEntry = YES;
        
        [_mainScrollView addSubview:textField];
        [textField release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, point2.y, 75, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentRight;
        label.text = [nameArr objectAtIndex:i];
        [_mainScrollView addSubview:label];
        [label release];
        
        point.y += 45;
        point2.y += 45;
    }
    
    point2 = CGPointMake(14, 4*38 + 15 + 4*7 + 24);
    UIImage *image = [UIImage imageNamed:@"bg_registerBtn.png"];
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(point2.x, point2.y, image.size.width, image.size.height)];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setBackgroundImage:image forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:nextButton];
    [nextButton release];
    
    [self.view addSubview:_mainScrollView];
    [_mainScrollView release];
    
    [nameArr release];

}

- (void)initNavTitleView
{
    [self.navigationController.navigationBar addBgImageView];
    [self initTitleView];
    [self setNavigationBarTitle:@"用户注册(必填)"];
}

- (void)showMatchErrorAlertView:(NSInteger)index
{
    NSString *errorString = nil;
    switch (index) {
        case 0:
            errorString = @"用户名: 请输入汉字、字母、数字，最多100个字符";
            break;
        case 1:
            errorString = @"设置密码: 请输入字母、数字，最多20个字符";
            break;
        case 2:
            errorString = @"确认密码: 请输入相同的密码";
            break;
        case 3:
            errorString = @"请输入正确的手机号";
            break;
        default:
            break;
    }
    
    KKCustomAlertView   *alertView = [[KKCustomAlertView alloc] initWithMessage:errorString WithType:KKCustomAlertView_default];
    [alertView addButtonWithTitle:@"确定" imageName:@"alert-blue-button.png" block:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark Events

- (void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextButtonClicked
{
    [self resignVcFirstResponder];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (int index = 0 ; index < 4 ; index ++)
    {
        KKCustomTextField *textFieldView = [self findNextTextFieldViewFromView:_mainScrollView WithIndex:(10 + index)];
        [dataArray addObject:[textFieldView.textField.text length] > 0 ? [NSString stringWithFormat:@"%@",textFieldView.textField.text] : @""];
    }
    
    NSString *textString = nil;
    
    for (int t = 0; t < 4;t++)
    {
        textString = [dataArray objectAtIndex:t];
        
        if (t == 0)
        {
            if ([textString length] == 0)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"请输入用户名！"];
                return;
            }
            else if ([textString length] > 50)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"用户名最多输入50个字!"];
                return;
            }
            else if (![KKHelper KKHElpRegexMatchForTelephone:textString] && ![KKHelper KKHElpRegexMatchForEmail:textString] && ![KKHelper KKHElpRegexMatchForVehicleNo:textString])
            {
                [KKCustomAlertView showAlertViewWithMessage:@"用户名不合法，请重新输入！"];
                return;
            }
            
            if ([KKHelper KKHElpRegexMatchForVehicleNo:textString])
            {
                self.vehicleDetail.vehicleNo = textString;
            }
        }
        
        if (t == 1)
        {
            if ([textString length] == 0)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"请输入密码！"];
                return;
            }
            else if ([textString length] < 6)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"密码过短，请输入至少6位的密码!"];
                return;
            }
            else
            {
                NSRange range = [textString rangeOfString:@" "];
                if (range.location != NSNotFound)
                {
                    [KKCustomAlertView showAlertViewWithMessage:@"密码格式不正确，不能输入空格!"];
                    return;
                }
            }
        }
        
        if (t == 2)
        {
            if ([textString length] == 0)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"请输入确认密码！"];
                return;
            }
            else if (![textString isEqualToString:[dataArray objectAtIndex:1]])
            {
                [KKCustomAlertView showAlertViewWithMessage:@"请输入相同的密码！"];
                return;
            }
        }
        
        if (t == 3)
        {
            if ([textString length] == 0)
            {
                [KKCustomAlertView showAlertViewWithMessage:@"请输入手机号码！"];
                return;
            }
            else if (![KKHelper KKHElpRegexMatchForTelephone:textString])
            {
                [KKCustomAlertView showAlertViewWithMessage:@"手机号格式错误，请重新输入!"];
                return;
            }
        }
        
    }
    
    KKRegisterAccount2ViewController *nextVc = [[KKRegisterAccount2ViewController alloc] initWithNibName:@"KKRegisterAccount2ViewController" bundle:nil];
    nextVc.superVc = self;
    nextVc.aAccountName = [dataArray objectAtIndex:0];
    nextVc.aPasswordNum = [dataArray objectAtIndex:1];
    nextVc.aPhoneNum = [dataArray objectAtIndex:3];
    [self.navigationController pushViewController:nextVc animated:YES];
    [nextVc release];
    
    [dataArray release];
}

- (void) didKeyboardNotification:(NSNotification*)notification
{
    NSString* nName = notification.name;
    NSDictionary* nUserInfo = notification.userInfo;
    if ([nName isEqualToString:UIKeyboardDidShowNotification])
    {
        NSString* sysStr = [[UIDevice currentDevice] systemVersion];
        sysStr = [sysStr substringToIndex:1];
        NSInteger ver = [sysStr intValue];
        if (ver >= 5)
        {
            NSValue* value = [nUserInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGRect rect = CGRectZero;
            [value getValue:&rect];
            float keyboardHeight = rect.size.height;
            CGRect aRect = CGRectZero;
            KKCustomTextField *textFieldView = [self getCurrentFirstResponderTextFieldFromView:_mainScrollView];
            aRect = textFieldView.frame;
            CGRect sRect = _mainScrollView.frame;
            float height = currentScreenHeight - 44 - [self getOrignY] - keyboardHeight;
            sRect.size.height = height;
            [_mainScrollView setFrame:CGRectMake(sRect.origin.x, 0, sRect.size.width, height)];
            [_mainScrollView setContentOffset:CGPointZero animated:NO];
             if (!CGRectContainsPoint(sRect, CGPointMake(textFieldView.frame.origin.x, textFieldView.frame.origin.y + textFieldView.frame.size.height)) ) {
                 [_mainScrollView setContentOffset:CGPointMake(0, aRect.origin.y - 15) animated:YES];
             }
            
        }
    }
    if ([nName isEqualToString:UIKeyboardWillHideNotification])
    {
        [_mainScrollView setFrame:CGRectMake(0, 0, 320, currentScreenHeight - 44 - [self getOrignY])];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100 && [textField.text length] > 0)
    {
        if (![KKHelper KKHElpRegexMatchForEmail:textField.text])
            textField.text = [textField.text uppercaseString];
        
        if ([KKHelper KKHElpRegexMatchForTelephone:textField.text])
        {
            KKCustomTextField *nextTextFieldView = [self findNextTextFieldViewFromView:_mainScrollView WithIndex:13];
            nextTextFieldView.textField.text = textField.text;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    KKCustomTextField *textFieldView = [self getCurrentFirstResponderTextFieldFromView:_mainScrollView];
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        [textField resignFirstResponder];
        KKCustomTextField *nextTextFieldView = [self findNextTextFieldViewFromView:_mainScrollView WithIndex:textFieldView.index + 1];
        [nextTextFieldView.textField becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    
    return YES;
}


#pragma mark -
#pragma mark Handle memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _mainScrollView = nil;
}

- (void)dealloc
{
    _mainScrollView = nil;
    self.vehicleDetail = nil;
    [super dealloc];
}
@end

