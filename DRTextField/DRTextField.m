//
//  DRTextField.m
//  DRTextField
//
//  Created by liu on 2018/5/8.
//  Copyright © 2018年 liu. All rights reserved.
//

#import "DRTextField.h"

@interface Label:UILabel
@property (nonatomic,assign) UIEdgeInsets insets;
@end
@implementation Label
-(void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@interface TextField:UITextField
@property (nonatomic,assign) UIEdgeInsets insets;
@end
@implementation TextField
//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.insets);
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.insets);
}
@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@interface DRTextField()<UITextFieldDelegate>{
    NSString *_text;//必须申明，不然get／set报错
}
@property (nonatomic,strong) Label *tipLabel;
@property (nonatomic,strong) TextField *textField;

///已经输入的字符大小
@property (nonatomic,strong) NSNumber *inTypeLength;
@end

@implementation DRTextField
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tipLabel = [[Label alloc] initWithFrame:(CGRect){0,0,CGRectGetWidth(frame),20}];
        self.tipLabel.backgroundColor = [UIColor clearColor];
        self.tipLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.tipLabel];
        
        self.textField = [[TextField alloc] initWithFrame:(CGRect){0,20,CGRectGetWidth(frame),CGRectGetHeight(frame)-20} ];
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.textColor = [UIColor blackColor];
        self.textField.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.textField];
        
        self.textField.delegate = self;
        self.textField.layer.cornerRadius = 5;
        self.tipLabel.frame = self.textField.frame;
        
    }
    return self;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.tipLabel.textColor = self.placeHolderColor;
    self.tipLabel.text = self.placeHolder;
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        self.tipLabel.frame = (CGRect){0,0,CGRectGetWidth(self.bounds),20};
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (!textField.text || [textField.text isEqualToString:@""]) {
        [self.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            self.tipLabel.frame = (CGRect){0,20,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)-20};
        }];
    }else{
        if (self.verifyInputBlock) {
            NSString *tipString = self.verifyInputBlock([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
            if (tipString) {
                self.tipLabel.textColor = [UIColor orangeColor];
                self.tipLabel.text = tipString;
                CATransition *positionTransition = [CATransition animation];
                positionTransition.type = kCATransitionPush;
                positionTransition.subtype = kCATransitionFromBottom;
                
                [self.tipLabel.layer addAnimation:positionTransition forKey:nil];
                
            }
        }
    }
}


-(BOOL)resignFirstResponder{
    [self.textField resignFirstResponder];
   return [super resignFirstResponder];
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.tipLabel.text = placeHolder;
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    self.tipLabel.textColor = placeHolderColor;
    
}

-(void)setText:(NSString *)text{
    _text = text;
    self.textField.text = text;
}


-(NSString*)text{
    if (![self.tipLabel.text isEqualToString:self.placeHolder]) {
        return nil;
    }
    return self.textField.text;
}

-(void)setTipFont:(UIFont *)tipFont{
    _tipFont = tipFont;
    self.tipLabel.font = tipFont;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.textField.font = textFont;
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.textField.layer.borderColor = borderColor.CGColor;
}

-(void)setBorderWidth:(NSInteger)borderWidth{
    _borderWidth = borderWidth;
    self.textField.layer.borderWidth = borderWidth;
}

-(void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    self.tipLabel.insets = contentInsets;
    self.textField.insets = contentInsets;
}
@end
