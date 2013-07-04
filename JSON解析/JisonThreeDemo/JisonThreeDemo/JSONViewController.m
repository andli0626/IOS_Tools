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
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=648688478"];
//    定义一个NSError对象，用于捕获错误信息
    NSError *error;
//    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];    
//    NSLog(@"jsonstring--->%@",jsonString);
//    将解析得到的内容存放字典中，编码格式UTF8，防止取值时候发生乱码
    NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[jsonString dataUsingEncoding:NSUTF8StringEncoding] error:&error];
//    因为返回的Json文件有两层，去第二层类容放到字典中去0
    NSDictionary *results = [rootDic objectForKey:@"results"];

    NSLog(@"Versiong=%@",[results objectForKey:@"version"]);

}

- (IBAction)buttonPressedtwo:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=648688478"];
    NSError *error=nil;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];  
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    
    NSDictionary *rootDic = [parser objectWithString:jsonString error:&error];
    NSDictionary *results = [rootDic objectForKey:@"results"];
    NSLog(@"Versiong=%@",[results objectForKey:@"version"]);
    
}

- (IBAction)buttonPressedthree:(id)sender {
    NSError *error;
//    加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=648688478"]];
//    将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    iOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    weatherDic字典中存放的数据也是字典型，从它里面通过键值取值
    NSArray *results = [weatherDic objectForKey:@"results"];
   NSLog(@"Versiong=%@",[results objectForKey:@"version"]);
}
@end
