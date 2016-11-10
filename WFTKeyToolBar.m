//
//  WFTKeyToolBar.m
//  WorkForceTracker
//
//  Created by Admin on 21/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "WFTKeyToolBar.h"

@implementation WFTKeyToolBar

- (id)initWithFrame:(CGRect)frame withDelegate:(id<WFTKeyToolBarDelegate>)delegate withPreviousNextItems:(BOOL)isPreviousNext
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.delegate = delegate;
        self.barStyle = UIBarStyleBlack;
        
       
        UIBarButtonItem *barBtnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(WFT_actionDone)];
        UIBarButtonItem *barBtnFlexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        if (isPreviousNext)
        {
            _barBtnPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(WFT_actionPrevious)];
            
            _barBtnNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(WFT_actionNext)];
       
             [self setItems:@[_barBtnPrevious , _barBtnNext,barBtnFlexSpace , barBtnDone] animated:YES];
        }
        else
        {
            [self setItems:@[barBtnFlexSpace ,barBtnDone] animated:YES];

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

- (void)dealloc
{
    _barBtnNext     = nil;
    _barBtnPrevious = nil;
    
}

#pragma mark - UIBarButtonItem Actions

- (void)WFT_actionDone
{
    [self.delegate actionDoneBtn];
}

- (void)WFT_actionNext
{
    [self.delegate actionNextBtn];
}
- (void)WFT_actionPrevious
{
    [self.delegate actionPreviousBtn];
}



@end
