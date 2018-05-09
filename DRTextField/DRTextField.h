//
//  DRTextField.h
//  DRTextField
//
//  Created by liu on 2018/5/8.
//  Copyright © 2018年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRTextField : UIView
@property (nonatomic,strong) NSString *placeHolder;
@property (nonatomic,strong) UIColor *placeHolderColor;
@property (nonatomic,strong) NSString *(^verifyInputBlock)(NSString *text);
@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) UIFont *tipFont;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) NSInteger borderWidth;
@property (nonatomic,assign) UIEdgeInsets contentInsets;

@property (nonatomic,strong) NSString *errorMsg;
@end
