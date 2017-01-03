//
//  YLUtility.m
//  YL_IOS_Internationalization
//
//  Created by YouLing on 2016/12/25.
//  Copyright © 2016年 YouLing. All rights reserved.
//

#import "YLUtility.h"

@implementation YLUtility

/*
 *设置城全局的bundel
 */
static NSBundle* bundle = nil;
#pragma mark -- 是否让修改自定义语言
/*
 *获取记录是否让修改语言
 */
+(NSString*) getWhetherCustomLanguage
{
    
    NSString* whether = [[NSUserDefaults standardUserDefaults] objectForKey:WHETHER_CUSTOM_LANGUAGE];
    if (whether == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:WHETHER_CUSTOM_LANGUAGE];
        whether = @"NO";
    }
    return whether;
}
/*
 *设置是否让修改语言
 */
+(BOOL) setWhetherCustomLanguage:(NSString*) whether
{
    if([whether isEqualToString:@"YES"] || [whether isEqualToString:@"NO"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:whether forKey:WHETHER_CUSTOM_LANGUAGE];
    }
    return NO;
}
#pragma mark -- 自定义语言的一些操作
/*
 *获取当前系统的语言
 */
+(NSString*) getSysCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSArray* array = [currentLanguage componentsSeparatedByString:@"-"];
    /*
     *这里对语言的字符进行处理
     */
    return [currentLanguage stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"-%@",array.lastObject] withString:@""];
}
/*
 *获取当前自定义的语言，这里将自定义的语言类型放到的NSUserDefaults
 */
+(NSString*) getCustomCurrentLanguage
{
    //[NSUserDefaults standardUserDefaults]
    NSString* currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:CUSTOM_LANGUAGE];
    if(currentLanguage == nil)
    {
        NSString* sysCurrentLanguage = [YLUtility getSysCurrentLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:sysCurrentLanguage forKey:CUSTOM_LANGUAGE];
        currentLanguage = sysCurrentLanguage;
    }
    return currentLanguage;
}
/*
 *设置当前自定义的语言
 */
+(void) setCuntomCurrentLanguage:(NSString*) customCurrntLanguage
{
    if(customCurrntLanguage != nil && customCurrntLanguage.length >1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:customCurrntLanguage forKey:CUSTOM_LANGUAGE];
    }
}
/*
 *获取NSBundle
 */
+(NSBundle*) getLanguageBundle
{
    /*
     *如果bundle为空时，就用系统默认的语言进行赋值
     */
    if (bundle == nil) {
        
        if([[YLUtility getWhetherCustomLanguage] isEqualToString:@"NO"])
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:[YLUtility getSysCurrentLanguage] ofType:@"lproj"];
            bundle = [NSBundle bundleWithPath:path];//生成bundle
        }
        else
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:[YLUtility getCustomCurrentLanguage] ofType:@"lproj"];
            bundle = [NSBundle bundleWithPath:path];//生成bundle

        }
        
    }
    return bundle;
}
/*
 *改变NSBundel
 */
+(NSBundle*) changeLanguageBundle:(NSString*) languageType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:languageType ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    return bundle;
}
@end
