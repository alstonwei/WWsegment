//
//  WWSegmentView.m
//  CoachProject
//
//  Created by Shouqiang Wei on 15/12/22.
//  Copyright © 2015年 教练助理. All rights reserved.
//

#import "WWSegmentView.h"


#define kBtnWidth 90
#define kBtnHeight 35

#define kHeightLightColor WWRGB(237,97,0)

#define kNormalColor WWRGB(31,34,40)

@implementation WWButton
- (void)setHighlighted:(BOOL)highlighted{}

+(WWButton*)customImageButtonItemWithNormalImage:(NSString*)noremalImage highlight:(NSString*)hightlight
{
    WWButton* btn = [WWButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:noremalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightlight] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:hightlight] forState:UIControlStateHighlighted];
    return btn;
}

@end

@interface WWSegmentView()
{
    UIButton *_currentBtn;
}


@property(nonatomic,strong)NSMutableArray* coreTitles;

@property(nonatomic,strong)UIImage* hightlightImage;
@property(nonatomic,strong)UIImage* normalImage;

@property(nonatomic,strong)NSMutableArray* subButtons;

@property(nonatomic,strong)NSMutableArray* subSeperateLins;

@end

@implementation WWSegmentView


- (id)initWithTitles:(NSMutableArray *)titles
{
    if (self = [super init]) {
        self.titles = titles;
    }
    return self;
}

-(void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex
{
    _selectedSegmentIndex = selectedSegmentIndex;
    if (self.subButtons.count>0 && self.subButtons.count>=selectedSegmentIndex) {
        WWButton* btn = self.subButtons[selectedSegmentIndex];
        if (!self.disableSelected) {
            _currentBtn.selected = NO;
            btn.selected = YES;
        }
        _currentBtn = btn;
    }
}

- (void)btnDown:(UIButton *)btn
{
    if (!self.disableSelected) {
        _currentBtn.selected = NO;
        btn.selected = YES;
    }
     _currentBtn = btn;
    _selectedSegmentIndex = btn.tag;
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:)]) {
        [self.delegate segmentView:self didSelectedSegmentAtIndex:btn.tag];
    }
}

-(void)addSegmentWithTitle:(NSString*)title atIndex:(NSInteger)idx
{
    WWButton *btn = [WWButton buttonWithType:UIButtonTypeCustom];
    btn.tag = idx;
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置监听器
    [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [btn setBackgroundColor:self.segementItemNormalBGColor];
    // 设置选中
    if (idx == 0 && self.autoSelected) {
        [self btnDown:btn];
    }
    // 添加按钮
    [self addSubview:btn];
    [self.subButtons insertObject:btn atIndex:idx];
    [self.coreTitles insertObject:title atIndex:idx];
}

-(void)insertSegmentItem:(WWButton*)item atIndex:(NSInteger)idx
{
    if (item) {
        item.tag = idx;
        [item addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
        [item setBackgroundColor:self.segementItemNormalBGColor];
        // 设置选中
        if (idx == 0 && self.autoSelected) {
            [self btnDown:item];
        }
        // 添加按钮
        [self addSubview:item];
        [self.subButtons insertObject:item atIndex:idx];
        [self.coreTitles insertObject:[NSString stringWithFormat:@"%zd",item.hash] atIndex:idx];
    }
   
}

- (void)setTitles:(NSArray *)titles
{
    // 数组内容一致，直接返回
    if ([titles isEqualToArray:_titles]) return;
    _titles = [titles mutableCopy];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger count = titles.count;
    
    for (NSInteger i = 0; i<count; i++) {
        NSString* title = titles[i];
        [self addSegmentWithTitle:title atIndex:i];
        if (i -1>=0) {
            [self createSeperateLine];
        }
    }
}

-(UIView*)createSeperateLine
{
    UIView* line = [[UIView alloc] initWithFrame:CGRectZero];
    [line setBackgroundColor:self.segementLineColor];
    [self addSubview:line];
    [self.subSeperateLins addObject:line];
    return line;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat buttonw =(w-((self.subButtons.count-1)*self.segementItemSpacing))/self.subButtons.count;
    CGFloat buttonh =h,buttonx= 0,buttony = 0;
    for (int index = 0; index <self.subButtons.count; index++) {
        WWButton* btn = self.subButtons[index];
        buttonx = index*(buttonw + self.segementItemSpacing);
        CGRect tabFrame = CGRectMake(buttonx, buttony, buttonw, buttonh);
        [btn setFrame:tabFrame];
        btn.tag = index;
        [self configSegementItem:btn];
        //
        if (index>0 && self.segementItemSpacing>0) {
            UIView* line;
            CGFloat lineX = index * (buttonw+self.segementItemSpacing) - self.segementItemSpacing;
            if ( self.subSeperateLins.count>0 && self.subSeperateLins.count>index-1) {
                line = self.subSeperateLins[index-1];
            }
            else
            {
                line = [self createSeperateLine];
            }
            [line setFrame:CGRectMake(lineX, buttony, self.segementItemSpacing, buttonh)];
            [self bringSubviewToFront:line];
        }
    }
    
    if (self.segementBorderWidth>0) {
        self.layer.cornerRadius = self.segementCornerRadius;
        self.layer.borderWidth = self.segementBorderWidth;
        self.layer.borderColor = self.segementBorderColor.CGColor;
    }
    self.layer.cornerRadius = self.segementCornerRadius;
    [self setClipsToBounds:YES];
}


-(void)configSegementItem:(WWButton*)btn
{
    [btn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:self.hightlightImage forState:UIControlStateSelected];
    // 设置文字
    // btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = self.segementItemTitleFont;
    [btn setTitleColor:self.segementItemNormalTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:self.segementItemHighlightTitleColor forState:UIControlStateSelected];
    
}

-(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
#pragma mark getter setter

-(UIColor *)segementBorderColor
{
    if (!_segementBorderColor) {
        _segementBorderColor = kHeightLightColor;
    }
    return _segementBorderColor;
}
-(UIColor *)segementLineColor
{
    if (!_segementLineColor) {
        _segementLineColor = kHeightLightColor;
    }
    return _segementLineColor;
}


-(UIColor *)segementItemHighlightBGColor
{
    if (!_segementItemHighlightBGColor) {
        _segementItemHighlightBGColor = kHeightLightColor;
    }
    return _segementItemHighlightBGColor;
}

-(UIColor *)segementItemNormalBGColor
{
    if (!_segementItemNormalBGColor) {
        _segementItemNormalBGColor = kNormalColor;
    }
    return _segementItemNormalBGColor;
}



-(UIColor *)segementItemHighlightTitleColor
{
    if (!_segementItemHighlightTitleColor) {
        _segementItemHighlightTitleColor = kNormalColor;
    }
    return _segementItemHighlightTitleColor;
}

-(UIColor *)segementItemNormalTitleColor
{
    if (!_segementItemNormalTitleColor) {
        _segementItemNormalTitleColor = kHeightLightColor;
    }
    return _segementItemNormalTitleColor;
}

-(UIFont *)segementItemTitleFont
{
    if (!_segementItemTitleFont) {
        _segementItemTitleFont = [UIFont systemFontOfSize:16];
    }
    return _segementItemTitleFont;
}

-(UIImage *)hightlightImage
{
    if (!_hightlightImage) {
        _hightlightImage = [self imageWithColor:self.segementItemHighlightBGColor withFrame:CGRectMake(0, 0, 500, 500)];
    }
    return _hightlightImage;
}

-(UIImage *)normalImage
{
    if (!_normalImage) {
        _normalImage = [self imageWithColor:self.segementItemNormalBGColor withFrame:CGRectMake(0, 0, 500, 500)];
    }
    return _normalImage;
}

-(NSMutableArray *)subButtons
{
    if (!_subButtons) {
        _subButtons = [NSMutableArray array];
    }
    return _subButtons;
}
-(NSMutableArray *)subSeperateLins
{
    if (!_subSeperateLins) {
        _subSeperateLins = [NSMutableArray array];
    }
    return _subSeperateLins;
}

- (NSMutableArray *)coreTitles
{
    if (!_coreTitles) {
        _coreTitles = [NSMutableArray array];
    }
    return _coreTitles;
}

@end
