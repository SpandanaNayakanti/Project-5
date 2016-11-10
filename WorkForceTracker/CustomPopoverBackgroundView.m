//
//  CustomPopoverBackgroundView.m
//  Marksman
//
//  Created by Admin on 16/08/12.
//
//

#import "CustomPopoverBackgroundView.h"

@implementation CustomPopoverBackgroundView

-  (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat fullHeight = self.frame.size.height;
    CGFloat fullWidth = self.frame.size.width;
    CGFloat startingLeft = 0.0;
    CGFloat startingTop = 0.0;
    CGFloat arrowCoord = 0.0;
    
    UIImage *arrow;
    UIImageView *arrowView;
    
    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp:
            startingTop += 2.0;
            fullHeight -= 2.0;
            //the image line.png will be the corner
            arrow = [UIImage imageNamed:@"line.png"];
            arrowCoord = (self.frame.size.width / 2) - self.arrowOffset;
            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowCoord, 0, 2.0, 2.0)];
            break;
            
            
        case UIPopoverArrowDirectionDown:
            fullHeight -= 2.0;
            arrow = [UIImage imageNamed:@"line.png"];
            arrowCoord = (self.frame.size.width / 2) - self.arrowOffset;
            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowCoord, fullHeight, 2.0, 2.0)];
            break;
            
        case UIPopoverArrowDirectionLeft:
            startingLeft += 2.0;
            fullWidth -= 2.0;
            arrow = [UIImage imageNamed:@"line.png"];
            arrowCoord = (self.frame.size.height / 2) - self.arrowOffset;
            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, arrowCoord, 2.0, 2.0)];
            break;
            
        case UIPopoverArrowDirectionRight:
            fullWidth -= 2.0;
            arrow = [UIImage imageNamed:@"line.png"];
            arrowCoord = (self.frame.size.height / 2) - self.arrowOffset;
            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-2.0, arrowCoord, 2.0, 2.0)];
            break;
            
        case UIPopoverArrowDirectionAny:
//            fullWidth -= 2.0;
//            arrow = [UIImage imageNamed:@"line.png"];
//            arrowCoord = (self.frame.size.height / 2) - self.arrowOffset;
//            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-2.0, arrowCoord, 2.0, 2.0)];
            break;
            
        case UIPopoverArrowDirectionUnknown:
//            fullWidth -= 2.0;
//            arrow = [UIImage imageNamed:@"line.png"];
//            arrowCoord = (self.frame.size.height / 2) - self.arrowOffset;
//            arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-2.0, arrowCoord, 2.0, 2.0)];
            break;
            
    }
    
//    arrowView.layer.shadowColor = [UIColor redColor].CGColor;
//    arrowView.layer.shadowOpacity = 0;
//    arrowView.layer.shadowRadius = 0;
//    arrowView.layer.shadowOffset = CGSizeMake(-10.0f, 10.0f);
    //this image will be your background
//    UIImage *bg = [[UIImage imageNamed:@"dot_red.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
//    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(startingLeft, startingTop, fullWidth, fullHeight)] autorelease];
//    [imageView setImage:bg];
    [arrowView setImage:arrow];
//    [self addSubview:imageView];
    [self addSubview:arrowView];
}



- (CGFloat) arrowOffset {
    return offset;    
}



- (void) setArrowOffset:(CGFloat)arrowOffset {
    offset = arrowOffset;
    [self setNeedsLayout];    
}

- (UIPopoverArrowDirection)arrowDirection {    
    return direction;    
}
- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    direction = arrowDirection;
    [self setNeedsLayout];
}
+ (CGFloat)arrowHeight {
    return 1.0;
}
+ (CGFloat)arrowBase {
    return 1.0;
}

+ (UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

@end
