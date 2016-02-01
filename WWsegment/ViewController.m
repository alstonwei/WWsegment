//
//  ViewController.m
//  WWsegment
//
//  Created by epailive on 16/2/1.
//
//

#import "ViewController.h"
#import "WWSegmentView.h"


@interface ViewController ()<WWSegmentViewDelegate>


@property(nonatomic,strong)NSArray* titlesArray;
@property (weak, nonatomic) IBOutlet WWSegmentView *segment;
@property (weak, nonatomic) IBOutlet UIView *containerView1;
@property (weak, nonatomic) IBOutlet UIView *containerView2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegment01];
    [self addSegment02];
    [self setupSegment];
}

- (void)addSegment01 {

    
    WWSegmentView* segmentView01 = [[WWSegmentView alloc] initWithFrame:self.containerView1.bounds];
    
    segmentView01.delegate = self;
    segmentView01.segementCornerRadius = 3;
    segmentView01.segementBorderWidth = 1;
    segmentView01.autoSelected = YES;
    [segmentView01 setTitles:@[@"会员", @"潜力客户1", @"潜力客户2",@"潜力客户3", @"潜力客户4"]];
    [self.containerView1 addSubview:segmentView01];
}

//custom
- (void)addSegment02{
    
    WWSegmentView* segmentView01 = [[WWSegmentView alloc] initWithFrame:self.containerView1.bounds];
    
    segmentView01.delegate = self;
    segmentView01.segementCornerRadius = 3;
    segmentView01.segementBorderWidth = 1;
    segmentView01.autoSelected = YES;
    [segmentView01 setTitles:@[@"会员", @"潜力客户1", @"潜力客户2",@"潜力客户3", @"潜力客户4"]];
    
    WWButton* item = [WWButton customImageButtonItemWithNormalImage:@"like_highlight" highlight:@"like_normal"];
    [self.segment insertSegmentItem:item atIndex:0];

    [self.containerView2 addSubview:segmentView01];
}


-(void)setupSegment
{
    [self.segment setSegementItemHighlightBGColor:WWRGB(255, 116, 67)];
    [self.segment setSegementItemNormalBGColor:WWRGB(31, 34, 40)];
    [self.segment setSegementItemNormalTitleColor:WWRGB(255, 116, 67)];
    [self.segment setSegementItemHighlightTitleColor:WWRGB(31, 34, 40)];
    self.segment.delegate =self;
    [self.segment setSegementItemSpacing:1];
    [self.segment setSegementLineColor:WWRGB(4, 5, 7)];
    [self.segment setSegementItemTitleFont:[UIFont systemFontOfSize:14]];
    [self.segment setAutoSelected:YES];
    [self.segment setTitles:self.titlesArray];
}

#pragma mark WWSegmentViewDelegate
- (void)segmentView:(WWSegmentView *)segmentView didSelectedSegmentAtIndex:(NSUInteger)index
{
    NSLog(@" segmentView  didSelectedSegmentAtIndex:%lu",(unsigned long)index);
    
    NSString* msg = [NSString stringWithFormat:@"您点击了第%lu个",(unsigned long)index];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"tishi" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

-(NSArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray = @[@"ALL",@"体态图",@"肌肉图",@"食物热爱",@"运动消耗"];
    }
    return _titlesArray;
}

@end
