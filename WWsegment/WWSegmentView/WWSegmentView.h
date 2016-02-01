//
//  WWSegmentView.h
//  CoachProject
//
//  Created by Shouqiang Wei on 15/12/22.
//  Copyright © 2015年 教练助理. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WWRGB(r, g, b)\
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface WWButton: UIButton

@property(nonatomic,assign)BOOL isImageButton;

+(WWButton*)customImageButtonItemWithNormalImage:(NSString*)noremalImage highlight:(NSString*)hightlight;

@end

@class WWSegmentView;

@protocol WWSegmentViewDelegate <NSObject>
@optional;
- (void)segmentView:(WWSegmentView *)segmentView didSelectedSegmentAtIndex:(NSUInteger)index;
@end

@interface WWSegmentView : UIView

- (id)initWithTitles:(NSArray *)titles;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<WWSegmentViewDelegate> delegate;
@property(nonatomic,assign)BOOL autoSelected;

@property(nonatomic,assign)NSUInteger selectedSegmentIndex;
@property(nonatomic,assign)CGFloat segementItemSpacing;
@property(nonatomic,strong)UIColor* segementLineColor;
@property(nonatomic,assign)CGFloat segementBorderWidth;
@property(nonatomic,assign)CGFloat segementCornerRadius;
@property(nonatomic,strong)UIColor* segementBorderColor;

//item

@property(nonatomic,strong)UIColor* segementItemHighlightBGColor;
@property(nonatomic,strong)UIColor* segementItemNormalBGColor;

@property(nonatomic,strong)UIColor* segementItemHighlightTitleColor;
@property(nonatomic,strong)UIColor* segementItemNormalTitleColor;
@property(nonatomic,strong)UIFont* segementItemTitleFont;
@property(nonatomic,assign)BOOL disableSelected;

-(void)addSegmentWithTitle:(NSString*)title atIndex:(NSInteger)idx;

//插入自定义的item，比如使用图片而不是用title的item
-(void)insertSegmentItem:(WWButton*)item atIndex:(NSInteger)idx;

@end
