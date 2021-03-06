//
//  TGOilBubbleView.m
//  TGOBD
//
//  Created by Jiahai on 14-3-6.
//  Copyright (c) 2014年 Bcgogo. All rights reserved.
//

#import "TGOilBubbleView.h"
#import "TGBasicModel.h"
#import "TGHelper.h"

@implementation TGOilBubbleView

static const float kBorderWidth = 10.0f;
static const float kEndCapWidth = 20.0f;
static const float kMaxLabelWidth = 220.0f;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        distanceLabel = [[UILabel alloc] init];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.numberOfLines = 0;
        distanceLabel.textColor = [UIColor blackColor];
        distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:distanceLabel];
        
        detailLabel = [[UILabel alloc] init];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.numberOfLines = 0;
        detailLabel.textColor = [UIColor blackColor];
        detailLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:detailLabel];
        
        UIImage *disclosureImage = [UIImage imageNamed:@"btn_Disclosure.png"];
        CGRect rect = CGRectZero;
        rect.size = disclosureImage.size;
        rightButton = [[UIButton alloc] initWithFrame:rect];
        [rightButton setImage:disclosureImage forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        rightButton.userInteractionEnabled = YES;
        [self addSubview:rightButton];
        
        UIImage *imageNormal, *imageHighlighted;
        imageNormal = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_left.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        imageHighlighted = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_left_highlighted.png"]
                            stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        UIImageView *leftBgd = [[UIImageView alloc] initWithImage:imageNormal
                                                 highlightedImage:imageHighlighted];
        leftBgd.tag = 11;
        
        imageNormal = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_right.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        imageHighlighted = [[UIImage imageNamed:@"mapapi.bundle/images/icon_paopao_middle_right_highlighted.png"]
                            stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal
                                                  highlightedImage:imageHighlighted];
        rightBgd.tag = 12;
        
        [self addSubview:leftBgd];
        [self sendSubviewToBack:leftBgd];
        [self addSubview:rightBgd];
        [self sendSubviewToBack:rightBgd];
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

-(void) setUIFit
{
    [self showFromRect:CGRectZero];
}

- (BOOL)showFromRect:(CGRect)rect {
    if (self.oilStation == nil) {
        return NO;
    }
    
    titleLabel.text = self.oilStation.name;
    titleLabel.frame = CGRectZero;
    [titleLabel sizeToFit];
    CGRect rect1 = titleLabel.frame;
    rect1.origin = CGPointMake(kBorderWidth, kBorderWidth);
    if (rect1.size.width > kMaxLabelWidth) {
        rect1.size.width = kMaxLabelWidth;
    }
    titleLabel.frame = rect1;
    
    distanceLabel.text = [NSString stringWithFormat:@"距离：%@",[TGHelper meterToKiloFromInt:self.oilStation.distance]];
    distanceLabel.frame = CGRectZero;
    [distanceLabel sizeToFit];
    CGRect rect13 = distanceLabel.frame;
    rect13.origin.x = kBorderWidth;
    rect13.origin.y = rect1.size.height + 2*kBorderWidth;
    if (rect13.size.width > kMaxLabelWidth) {
        rect13.size.width = kMaxLabelWidth;
    }
    distanceLabel.frame = rect13;
    
    NSMutableString *strBuf = [[NSMutableString alloc] initWithString:@"今日油价："];
    NSArray *priceKeys = [self.oilStation.gastprice allKeys];
    for(int i=0;i<[priceKeys count];i++)
    {
        [strBuf appendString:[NSString stringWithFormat:@"%@:%@, ",[priceKeys objectAtIndex:i] ,[self.oilStation.gastprice objectForKey:[priceKeys objectAtIndex:i]]]];
    }
    NSString *str = strBuf;
    if(strBuf.length > 2)
    {
        str = [strBuf substringWithRange:NSMakeRange(0, strBuf.length-2)];
    }
    detailLabel.text = str;
    
    detailLabel.frame = CGRectZero;
    //    l.lineBreakMode = UILineBreakModeWordWrap; l.numberOfLines = 0;
    [detailLabel sizeToFit];
    CGRect rect2 = detailLabel.frame;
    rect2.origin.x = kBorderWidth;
    rect2.origin.y = rect1.size.height + rect13.size.height + 2*kBorderWidth;
    if (rect2.size.width > kMaxLabelWidth) {
        rect2.size.width = kMaxLabelWidth;
        detailLabel.numberOfLines = 2;
        rect2.size.height = rect2.size.height*2;
    }
    detailLabel.frame = rect2;
    
    CGFloat longWidth = (rect1.size.width > rect2.size.width) ? rect1.size.width : rect2.size.width;
    CGRect rect0 = self.frame;
    rect0.size.height = rect1.size.height + rect2.size.height + rect13.size.height + 2*kBorderWidth + kEndCapWidth;
    rect0.size.width = longWidth + 2*kBorderWidth;
    if (rightButton.hidden == NO) {
        CGRect rect3 = rightButton.frame;
        rect3.origin.x = longWidth + 2*kBorderWidth;
        rect3.origin.y = kBorderWidth;
        rightButton.frame = rect3;
        rect0.size.width += rect3.size.width + kBorderWidth;
    }
    
    self.frame = rect0;
    
    CGFloat halfWidth = rect0.size.width/2;
    UIView *image = [self viewWithTag:11];
    CGRect iRect = CGRectZero;
    iRect.size.width = halfWidth;
    iRect.size.height = rect0.size.height;
    image.frame = iRect;
    image = [self viewWithTag:12];
    iRect.origin.x = halfWidth;
    image.frame = iRect;
    
    return YES;
}
-(void) rightBtnClicked
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(rightBtnClicked)])
        [self.delegate rightBtnClicked];
}

@end
