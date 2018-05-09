//
//  ViewController.m
//  DRTextField
//
//  Created by liu on 2018/5/8.
//  Copyright © 2018年 liu. All rights reserved.
//

#import "ViewController.h"
#import "DRTextField.h"
@interface ViewController ()
@property (nonatomic,strong) DRTextField *field;
@end

@implementation ViewController
- (IBAction)tapGesture:(id)sender {
    [self.field resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.field = [[DRTextField alloc] initWithFrame:(CGRect){20,50,300,50}];
    self.field.placeHolder = @"测试";
    self.field.placeHolderColor = [UIColor lightGrayColor];
    self.field.verifyInputBlock = ^NSString *(NSString *text) {
        if (text.length > 4) {
            return @"不能超过4个字符";
        }
        if (!text || [text isEqualToString:@""]) {
            return @"输入名称为空";
        }
        return nil;
    };
    [self.view addSubview:self.field];
    
    self.field.tipFont = [UIFont systemFontOfSize:10];
    self.field.textFont = [UIFont systemFontOfSize:20];
    self.field.borderWidth = 1;
    self.field.borderColor = [UIColor redColor];
    self.field.contentInsets = UIEdgeInsetsMake(1, 5, 1, 5);
    
    
}

- (IBAction)printTextField:(id)sender {
    NSLog(@"%@",self.field.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
