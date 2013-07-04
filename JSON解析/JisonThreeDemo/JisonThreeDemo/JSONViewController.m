//
//  JSONViewController.m
//  JisonThreeDemo
//
//  Created by rjxy on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JSONViewController.h"
#import "CJSONDeserializer.h"
#import "SBJson.h"

@interface JSONViewController ()

@end

@implementation JSONViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (IBAction)buttonPressedone:(id)sender {
//    获取API接口
    NSURL *url = [NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"];
//    定义一个NSError对象，用于捕获错误信息
    NSError *error;
//    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];    
//    NSLog(@"jsonstring--->%@",jsonString);
//    将解析得到的内容存放字典中，编码格式UTF8，防止取值时候发生乱码
    NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[jsonString dataUsingEncoding:NSUTF8StringEncoding] error:&error];
//    因为返回的Json文件有两层，去第二层类容放到字典中去0
    NSDictionary *weatherInfo = [rootDic objectForKey:@"weatherinfo"];
//    取值打印
    NSLog(@"今天是 %@ %@ %@ 的天气状况是:%@ %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"],[weatherInfo objectForKey:@"weather1"],[weatherInfo objectForKey:@"temp1"]);

}

- (IBAction)buttonPressedtwo:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://m.weather.com.cn/data/101180701.html"];
    NSError *error=nil;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];  
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    
    NSDictionary *rootDic = [parser objectWithString:jsonString error:&error];
    NSDictionary *weatherInfo = [rootDic objectForKey:@"weatherinfo"];
    /*
    NSArray *weatherArray = [rootDic objectForKey:@"weatherinfo"];
    for (NSDictionary *dic in weatherArray) {
        NSLog(@"----->%@",dic);
        NSLog(@"----->%@",[dic objectForKey:@"city"]);
    }
     */
    NSLog(@"今天是 %@ %@ %@ 的天气状况是:%@ %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"],[weatherInfo objectForKey:@"weather1"],[weatherInfo objectForKey:@"temp1"]);
    
}

- (IBAction)buttonPressedthree:(id)sender {
    NSError *error;
//    加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101180601.html"]];
//    将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    iOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    weatherDic字典中存放的数据也是字典型，从它里面通过键值取值
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    
    NSLog(@"今天是 %@ %@ %@ 的天气状况是:%@ %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"],[weatherInfo objectForKey:@"weather1"],[weatherInfo objectForKey:@"temp1"]);
//    打印出weatherInfo字典所存储数据
    NSLog(@"weatherInfo字典里面的内容是--->%@",[weatherInfo description]);
}
@end
