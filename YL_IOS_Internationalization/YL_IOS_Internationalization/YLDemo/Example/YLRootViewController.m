//
//  YLRootViewController.m
//  YL_IOS_Internationalization
//
//  Created by YouLing on 2016/12/25.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLRootViewController.h"
#import "YLUtility.h"
#import "Masonry.h"



@interface YLRootViewController ()
/*
 *title的语言的标识
 */
@property(nonatomic,strong) UILabel* label_title;
/*
 *label的用户名
 */
@property(nonatomic,strong) UILabel* label_name;
/*
 *label的用户名
 */
@property(nonatomic,strong) UILabel* label_password;
/*
 *UITextField 用户名
 */
@property(nonatomic,strong) UITextField* text_name;
/*
 *UITextField 用户密码
 */
@property(nonatomic,strong) UITextField* text_password;
/*
 *用户头像
 */
@property(nonatomic,strong) UIImageView* headImage;
/*
 *用来实现语言切换的
 */
@property(nonatomic,strong) UISegmentedControl* segmentedControl;
/*
 *是否支持自定义的语言切换，如果不支持的那么就是系统语言
 */
@property(nonatomic,strong) UISwitch * swithch;
/*
 *swithch需要显示的文本
 */
@property(nonatomic,strong) UILabel* label_swithch;

@end

@implementation YLRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setControlValue];
    [self initControlUI];
    [self setSegmentedControlState];
}

#pragma mark -- 懒加载

-(UILabel*) label_title
{
    if(_label_title == nil)
    {
        UILabel* label = [[UILabel alloc] init];
        _label_title =  label;
    }
    return _label_title;
}
-(UILabel*) label_name
{
    if(_label_name == nil)
    {
        UILabel* label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor blueColor]];
        [label setTextAlignment:NSTextAlignmentLeft];
        /*
         *设置圆角
         */
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        _label_name =  label;
    }
    return _label_name;
}
-(UILabel*) label_password
{
    if(_label_password == nil)
    {
        UILabel* label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor blueColor]];
        [label setTextAlignment:NSTextAlignmentLeft];
        /*
         *设置圆角
         */
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        _label_password = label;
    }
    return _label_password;
}
-(UITextField*) text_name
{
    if (_text_name == nil) {
        UITextField* text = [[UITextField alloc] init];
        text.backgroundColor  =  [UIColor whiteColor];
        [text setEnabled:NO];
        text.layer.cornerRadius = 5;
        text.clipsToBounds = YES;
        _text_name = text;
    }
    return _text_name;
}
-(UITextField*) text_password
{
    if (_text_password == nil) {
        UITextField* text = [[UITextField alloc] init];
        text.backgroundColor  =  [UIColor whiteColor];
        text.secureTextEntry = YES;
        [text setEnabled:NO];
        text.layer.cornerRadius = 5;
        text.clipsToBounds = YES;
        _text_password = text;
    }
    return _text_password;
}
-(UIImageView*) headImage
{
    if(_headImage == nil)
    {
         UIImageView* imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = YES;
        _headImage = imageView;
    }
    return _headImage;
}
-(UISegmentedControl*) segmentedControl
{
    if(_segmentedControl == nil)
    {
        UISegmentedControl* segmeted = [[UISegmentedControl alloc] initWithItems:@[@"English",@"简体中文",@"繁體中文"]];
        [segmeted addTarget:self action:@selector(segmentedControlChangValue:) forControlEvents:UIControlEventValueChanged];
                _segmentedControl = segmeted;
        
    }
    return _segmentedControl;
}
-(UISwitch*) swithch
{
    if(_swithch == nil)
    {
        UISwitch* s = [[UISwitch alloc] init];
        //[]
        [s addTarget:self action:@selector(swithchChangeValue:) forControlEvents:UIControlEventValueChanged];
        NSString* whether = [YLUtility getWhetherCustomLanguage];
        if([whether isEqualToString:@"YES"])
        {
            [s setOn:YES];
        }
        _swithch = s;
    }
    return _swithch;
}
-(UILabel*) label_swithch
{
    if (_label_swithch == nil) {
        UILabel* label = [[UILabel alloc] init];
       // [label setBackgroundColor:[UIColor whiteColor]];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        _label_swithch = label;
    }
    return _label_swithch;
}
#pragma mark -- UI初始化
-(void) initControlUI
{
    __weak __typeof(&*self) weakSelf = self;
    
    [self.view addSubview:self.label_title];
    
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@30);
        //设置水平居中
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.view.mas_top).offset(40);
    }];
   /*
    *头像显示
    */
    [self.view addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label_title.mas_bottom).offset(30);
       make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
    }];
    /*
     *将self.label_name和 self.text_name并排居中显示
     */
    [self.view addSubview:self.label_name];
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_lessThanOrEqualTo(weakSelf.headImage.mas_bottom).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(-80);
        
    }];
    [self.view addSubview:self.text_name];
    [self.text_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.label_name.mas_height);
        make.width.mas_equalTo(@150);
        make.top.equalTo(weakSelf.label_name.mas_top);
        make.centerX.equalTo(weakSelf.view.mas_centerX).offset(55);
           }];
    /*
     *将self.label_password和self.text_password并行
     */
    [self.view addSubview:self.label_password];
    [self.label_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label_name.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(-80);
        
    }];
    [self.view addSubview:self.text_password];
    [self.text_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label_password.mas_top);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(55);
        make.size.mas_equalTo(CGSizeMake(150, 30));
        
    }];
    /*
     *
     */
    [self.view addSubview:self.swithch];
    [self.swithch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.label_password.mas_bottom).offset(20);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(104);
    }];
    /*
     *
     */
    [self.view addSubview:self.label_swithch];
    [self.label_swithch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.swithch.mas_top);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(-22.5);
        make.size.mas_equalTo(CGSizeMake(215, 30));
    }];
    /*
     *切换语言
     */
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.swithch.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
}
#pragma mark-- 封装方法
/*
 *设置segmentedControl的状态
 */
-(void) setSegmentedControlState
{
    //[segmeted ]
    if([[YLUtility getWhetherCustomLanguage] isEqualToString:@"NO"])
    {
        [self.segmentedControl setEnabled:NO];
        NSString* syscurrentLanguage = [YLUtility getSysCurrentLanguage];
        if([syscurrentLanguage hasPrefix:@"en"])
        {
            [self.segmentedControl setSelectedSegmentIndex:0];
        }
        else if ([syscurrentLanguage hasPrefix:@"zh-Hans"]) {
            [self.segmentedControl setSelectedSegmentIndex:1];
        }
        else if([syscurrentLanguage hasPrefix:@"zh-Hant"])
        {
            [self.segmentedControl setSelectedSegmentIndex:2];
        }
        //  else if([syscurrentLanguage i])
    }
    else if([[YLUtility getWhetherCustomLanguage] isEqualToString:@"YES"])
    {
        [self.segmentedControl setEnabled:YES];
        NSString* customCurrentLanguage = [YLUtility getSysCurrentLanguage];
        if([customCurrentLanguage hasPrefix:@"en"])
        {
            [self.segmentedControl setSelectedSegmentIndex:0];
        }
        else if ([customCurrentLanguage hasPrefix:@"zh-Hans"]) {
            [self.segmentedControl setSelectedSegmentIndex:1];
        }
        else if([customCurrentLanguage hasPrefix:@"zh-Hant"])
        {
            [self.segmentedControl setSelectedSegmentIndex:2];
        }

    }

}
#pragma mark -- 各个控件的事件
/*
 *sUISwitch 事件
 */
-(void) swithchChangeValue:(UISwitch*) sender
{
    if(sender.isOn == YES)
    {
        [YLUtility setWhetherCustomLanguage:@"YES"];
    }
    else
    {
        [YLUtility setWhetherCustomLanguage:@"NO"];
    }
     [self setSegmentedControlState];
    //if(sender)

}
/*
 *语言切换
 */
-(void) segmentedControlChangValue:(UISegmentedControl*) sender
{
    NSInteger senderId = sender.selectedSegmentIndex;
    
    switch (senderId) {
        case 0:
            NSLog(@"英文");
            break;
        case 1:
            NSLog(@"简体中文");
            break;
        case 2:
            NSLog(@"繁体中文");
            break;
        default:
            break;
    }
    
}

#pragma mark -- 设置控件数据

-(void) setControlValue
{
    self.label_title.text = NSLocalizedString(@"Language-English", @"YLRootViewController——label_title");
    self.label_name.text = NSLocalizedString(@"userName:", @"YLRootViewController——label_name");
    self.label_password.text = NSLocalizedString(@"userPasw:", @"YLRootViewController——label_password");
    self.headImage.image = [UIImage imageNamed:NSLocalizedString(@"English.png", @"YLRootViewController-headImage")];
    self.text_name.text = NSLocalizedString(@"YouLing", @"YLRootViewController-text_name");
    self.text_password.text = NSLocalizedString(@"123456", @"LRootViewController-text_password");
    self.label_swithch.text = NSLocalizedString(@"WhetherCustomLanguage", @"LRootViewController-label_swithch");
}
-(void) viewDidLayoutSubviews
{
    /*
     *在这里能够打印控件的frame
     */
    //NSLog(@"text_name%f",self.view.frame.size.width-self.text_name.frame.origin.x-150);
    //NSLog(@"label_name%f",self.label_name.frame.origin.x);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
