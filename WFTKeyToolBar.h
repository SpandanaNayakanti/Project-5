//
//  WFTKeyToolBar.h
//  WorkForceTracker
//
//  Created by Admin on 21/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WFTKeyToolBarDelegate <NSObject>

@required

- (void)actionDoneBtn;

@optional

- (void)actionPreviousBtn;

- (void)actionNextBtn;


@end

@interface WFTKeyToolBar : UIToolbar

@property (nonatomic , strong) UIBarButtonItem *barBtnPrevious;

@property (nonatomic , strong) UIBarButtonItem *barBtnNext;

@property (nonatomic , assign) id <WFTKeyToolBarDelegate> delegate;



- (id)initWithFrame:(CGRect)frame withDelegate:(id<WFTKeyToolBarDelegate>)delegate withPreviousNextItems:(BOOL)isPreviousNext;

@end
