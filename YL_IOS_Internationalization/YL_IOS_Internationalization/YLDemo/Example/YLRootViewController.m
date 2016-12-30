//
//  YLRootViewController.m
//  YL_IOS_Internationalization
//
//  Created by YouLing on 2016/12/25.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLRootViewController.h"
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

@end

@implementation YLRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setControlValue];
    [self initControlUI];
    
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
    
    
}
#pragma mark -- 设置控件数据

-(void) setControlValue
{
    self.label_title.text = NSLocalizedString(@"Language-English", @"YLRootViewController——label_title");
    self.label_name.text = NSLocalizedString(@"userName:", @"YLRootViewController——label_name");
    self.label_password.text = NSLocalizedString(@"userPasw:", @"YLRootViewController——label_password");
    self.headImage.image = [UIImage imageNamed:NSLocalizedString(@"English.png", @"YLRootViewController-headImage")];
    self.headImage.backgroundColor  = [UIColor redColor];
    self.text_name.text = NSLocalizedString(@"YouLing", @"YLRootViewController-text_name");
    self.text_password.text = NSLocalizedString(@"123456", @"LRootViewController-text_password");
}
-(void) viewDidLayoutSubviews
{
    /*
     *在这里能够打印控件的frame
     */
    NSLog(@"text_name%f",self.view.frame.size.width-self.text_name.frame.origin.x-150);
    NSLog(@"label_name%f",self.label_name.frame.origin.x);
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
