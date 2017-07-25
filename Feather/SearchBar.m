//
//  SearchBar.m
//  Feather
//
//  Created by Renata Guttenová on 21/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation SearchBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
        return self;
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
        return self;
    }
    return nil;
}

-(void)commonSetup {
    NSString *className = NSStringFromClass([self class]);
    _view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
    _view.frame = self.bounds;
    _view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_view];
    self.clipsToBounds = YES;
    
    self.textField.delegate = self;
    [self.textField setFont:[UIFont nunitoBoldWithSize:30.0f]];
    
    self.view.backgroundColor = [UIColor purpleLight];
    
    [self configureAppearance];
}

- (void)configureAppearance {
    self.textField.placeholder = @"Enter a city!";
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"DEBUG---- textField did begin editing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"DEBUG---- textField did end editing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"TEXTFIELD TEXT: %@", textField.text);
    NSLog(@"REPLACEMENT STRING: %@", string);
    
    if ([string isEqualToString:@""]) {
        //deleting a character
        if (textField.text.length > 3 && range.location !=0) {
            NSLog(@"");
            [self.delegate textDidChange:[NSString stringWithFormat:@"%@%@", textField.text, string]];
        } else {
            [self.delegate textDidChange:@""];
        }
    } else {
        //adding a character
        if ((textField.text.length + string.length) >= 3) {
            [self.delegate textDidChange:[NSString stringWithFormat:@"%@%@", textField.text, string]];
        }
    }
    
    return YES;
}

@end
