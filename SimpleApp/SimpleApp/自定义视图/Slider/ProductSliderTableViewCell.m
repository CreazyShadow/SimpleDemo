//
//  ProductSliderTableViewCell.m
//  SimpleApp
//
//  Created by wuyp on 16/9/20.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ProductSliderTableViewCell.h"
#import "UIView+Extension.h"

static NSInteger const kLeftMargin = 15; ///< 左边距
static NSInteger const kRightMargin = 15; ///< 右边距
static NSInteger kTextLabelMargin = 15; ///< 文本控件之间距离

static NSInteger const kLeftRightRange = 1; ///< 左右按钮最少间隔

@interface ProductSliderTableViewCell()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

/**
 视图容器
 */
@property (nonatomic, strong) UIView *containerView;

/**
 背景图片：黑色
 */
@property (nonatomic, strong) UIImageView *backImageView;


/**
 前景图片：黄色
 */
@property (nonatomic, strong) UIImageView *frontImageView;

/**
 左边按钮
 */
@property (nonatomic, strong) UIButton *leftBtn;

/**
 右边按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;

/**
 线条集合
 */
@property (nonatomic, strong) NSMutableArray<UIImageView *> *lineArr;

/**
 文本集合
 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *eventArr;

@end

@implementation ProductSliderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Track"]];
    self.frontImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Track1"]];
    self.leftBtn = [[UIButton alloc] init];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnPan:)];
    [_leftBtn addGestureRecognizer:panGes];
    _leftBtn.tag = 10;
    _leftBtn.size = CGSizeMake(20, 20);
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    
    self.rightBtn = [[UIButton alloc] init];
    UIPanGestureRecognizer *rightPanGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnPan:)];
    [_rightBtn addGestureRecognizer:rightPanGes];
    _rightBtn.tag = 11;
    _rightBtn.size = CGSizeMake(20, 20);
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    
    self.containerView = [[UIView alloc] init];
    [self.scrollview addSubview:_containerView];
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.bounces = NO;
    
    [_containerView addSubview:_backImageView];
    [_containerView addSubview:_frontImageView];
    [_containerView addSubview:_leftBtn];
    [_containerView addSubview:_rightBtn];
}

- (void)setSource:(NSArray<NSString *> *)source {
    _source = source;
    
    if (source.count == 0) {
        return;
    }
    
    self.leftSelectedIndex = 0;
    self.rightSelectedIndex = source.count > 0 ? source.count - 1 : 0;
    
    _lineArr = [NSMutableArray array];
    _eventArr = [NSMutableArray array];
    
    for (int i = 0; i < source.count; i++) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        line.size = CGSizeMake(1, 20);
        [_containerView addSubview:line];
        [_lineArr addObject:line];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.text = @"测试";
        label.size = CGSizeMake(36, 20);
        [_containerView addSubview:label];
        [_eventArr addObject:label];
    }
    
    CGFloat textLabelWidth = _eventArr[0].width;
    CGFloat expectWidth = kLeftMargin + kRightMargin + source.count * textLabelWidth  + (source.count - 1) * kTextLabelMargin;
    CGFloat actualWidth = expectWidth > kScreenWidth ? expectWidth : kScreenWidth;
    //实际 文本Label的间距：如果当文本个数很少时需要重新计算
    kTextLabelMargin = expectWidth > kScreenWidth ? kTextLabelMargin : (kScreenWidth - (kLeftMargin + kRightMargin + source.count * textLabelWidth)) * 1.0 / (source.count - 1);
    
    //背景图片的位置
    _backImageView.x = kLeftMargin + textLabelWidth * 0.5 - self.leftBtn.width * 0.5;
    _backImageView.y = 20;
    _backImageView.height = 15;
    _backImageView.width = actualWidth - kLeftMargin - kRightMargin - 2 * (textLabelWidth * 0.5 - self.leftBtn.width * 0.5);
    
    _frontImageView.frame = _backImageView.frame;
    
    //按钮位置
    self.leftBtn.x = _backImageView.x;
    self.leftBtn.centerY = _backImageView.centerY;
    
    self.rightBtn.centerY = self.leftBtn.centerY;
    self.rightBtn.x = _backImageView.maxX - _rightBtn.width;
    
    //线条位置
    for (int i = 0; i < _lineArr.count; i++) {
        UIView *temp = _lineArr[i];
        temp.centerX = kLeftMargin + textLabelWidth * 0.5 + i * (textLabelWidth + kTextLabelMargin);
        temp.y = _backImageView.maxY;
    }
    
    //文本位置
    for (int i = 0; i < _eventArr.count; i++) {
        UILabel *temp = _eventArr[i];
        temp.x = kLeftMargin + i * (textLabelWidth + kTextLabelMargin);
        temp.y = _lineArr[i].maxY;
    }
    
    self.scrollview.contentSize = CGSizeMake(actualWidth, 120);
    self.containerView.frame = CGRectMake(0, 0, actualWidth, 120);
}

#pragma mark - 拖动button

- (void)btnPan:(UIPanGestureRecognizer *)ges {
    static CGFloat startMoveButtonX = 0;
    CGPoint location = [ges locationInView:self.containerView];
    UIButton *btn = (UIButton *)ges.view;
    
    if (self.source.count == 0) {
        return;
    }
    
    CGFloat textLabelWidth = _eventArr[0].width;
    NSInteger index = [self indexOfPoint:location.x];
    //判断是否能够拖动 两个按钮之间的距离最小为kLeftRightRange
    if (btn.tag == 10) {
        if (location.x + (textLabelWidth + kTextLabelMargin) * kLeftRightRange + 5 > self.rightBtn.centerX) {
            [self completedPositionChange:index view:ges.view startFrontWidth:startFrontWidth startFrontX:startFrontX startMoveButtonX:startMoveButtonX];
            return;
        }
    } else if (btn.tag == 11) {
        if (location.x - (textLabelWidth + kTextLabelMargin) * kLeftRightRange - 5> self.rightBtn.centerX) {
            [self completedPositionChange:index view:ges.view startFrontWidth:startFrontWidth startFrontX:startFrontX startMoveButtonX:startMoveButtonX];
            return;
        }
    }
    
    NSLog(@"%ld left:%ld right:%ld stop:%d",index,self.leftSelectedIndex,self.rightSelectedIndex,isStop);
    
    
    //开始滑动
    if (ges.state == UIGestureRecognizerStateBegan) {
        startMoveButtonX = ges.view.centerX;
        startFrontWidth = self.frontImageView.width;
        startFrontX = self.frontImageView.x;
    }
    
    //停止滑动
    if (ges.state == UIGestureRecognizerStateEnded) {
        NSInteger index = [self indexOfPoint:location.x];
        [self completedPositionChange:index view:ges.view startFrontWidth:startFrontWidth startFrontX:startFrontX startMoveButtonX:startMoveButtonX];
        return;
    }
    
    ges.view.centerX = location.x;
    //设置frontImageView的宽度
    if (ges.view.tag == 10) {
        self.frontImageView.x = startFrontX + location.x - startMoveButtonX;
        self.frontImageView.width = startFrontWidth- (location.x - startMoveButtonX);
    } else {
        self.frontImageView.width = startFrontWidth + (location.x - startMoveButtonX);
    }
}


- (void)completedPositionChange:(NSInteger)index view:(UIView *)view startFrontWidth:(CGFloat)startFrontWidth startFrontX:(CGFloat)startFrontX startMoveButtonX:(CGFloat)startMoveButtonX {
    
    if (view.tag == 10) {
        if (index + kLeftRightRange >= self.rightSelectedIndex) {
            index = self.rightSelectedIndex - kLeftRightRange;
        }
    } else if (view.tag == 11) {
        if (index - kLeftRightRange <= self.leftSelectedIndex) {
            index = self.leftSelectedIndex + kLeftRightRange;
        }
    }
    
    NSLog(@"---------%ld %lf %lf %lf",index,startFrontWidth,startFrontX,self.frontImageView.x);
    
    view.centerX = _lineArr[index].centerX;
    if (view.tag == 10) {
        self.leftSelectedIndex = index;
        if (self.SelectedCompletionAction) {
            self.SelectedCompletionAction(index, _rightSelectedIndex);
        }
        
//        self.frontImageView.x = view.centerX - kLineBackMargin;
        self.frontImageView.width = startFrontWidth - (self.frontImageView.x - startFrontX);
    } else if (view.tag == 11) {
        self.rightSelectedIndex = index;
        if (self.SelectedCompletionAction) {
            self.SelectedCompletionAction(_leftSelectedIndex, index);
        }
        
        self.frontImageView.width = startFrontWidth + (_lineArr[index].centerX - startMoveButtonX);
    }
}

- (int)indexOfPoint:(CGFloat)x {
    int temp = 0;
    for (int i = 0; i < _lineArr.count; i++) {
        if (x < _lineArr[i].x) {
            temp = i;
            break;
        }
    }
    
    if (temp == 0) {
        return temp;
    }
    
    CGFloat distanceLeft = x - _lineArr[temp - 1].x;
    CGFloat distanceRight = _lineArr[temp].x - x;
    
    return distanceLeft <= distanceRight ? temp - 1 : temp;
}

@end
