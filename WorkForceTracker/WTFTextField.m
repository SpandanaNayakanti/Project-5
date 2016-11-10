//
//  WTFTextField.m
//  WorkForceTracker
//
//  Created by karthik  on 12/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "WTFTextField.h"

@implementation WTFTextField

- (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withType:(NSString*)type isMandatory:(BOOL)mandatory withTagName:(NSString *)tagName
{
    self = [super init];
    if (self)
    {
        self.frame=frame;
        self.tag=tag;
        self.Type=type;
        self.tag_Name=tagName;
        NSLog(@"%d",self.tag);
        
        _isMandatory = mandatory;
        if ([self.Type isEqualToString:@"DECIMAL"])
        {
            self.typeTextfield=DECIMAL;
            self.keyboardType=UIKeyboardTypeDecimalPad;
            
        }
        if ([self.Type isEqualToString:@"DOUBLE"])
        {
            self.typeTextfield=DOUBLE;
            self.keyboardType=UIKeyboardTypeDecimalPad;
            
        }
       else if ([self.Type isEqualToString:@"VARCHAR"])
        {
            self.typeTextfield=VARCHAR;
            self.keyboardType=UIKeyboardTypeAlphabet;
        }
       else if ([self.Type isEqualToString:@"TIME"])
        {
            self.typeTextfield=TIME;
        }
        if ([self.Type isEqualToString:@"DATE"])
        {
            self.typeTextfield=Date;

        }
       
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
