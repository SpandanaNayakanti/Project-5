//
//  WFTButton.h
//  WorkForceTracker
//
//  Created by Anshu  on 25/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFTButton : UIButton

@property (nonatomic , assign) BOOL isMandatory;
@property (nonatomic , assign) NSString *tag_Name;

- (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag  isMandatory:(BOOL)mandatory withTagName:(NSString*)tagName;

@end
