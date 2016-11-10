//
//  WFTButton.m
//  WorkForceTracker
//
//  Created by karthik  on 25/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "WFTButton.h"

@implementation WFTButton

 - (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag  isMandatory:(BOOL)mandatory withTagName:(NSString*)tagName
{
    self = [super init];
    if (self)
    {
        self.frame     = frame;
        self.tag       = tag;
        _isMandatory   = mandatory;
        self.tag_Name  = tagName;
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
