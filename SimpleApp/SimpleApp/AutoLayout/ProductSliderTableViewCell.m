//
//  ProductSliderTableViewCell.m
//  SimpleApp
//
//  Created by wuyp on 16/9/20.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ProductSliderTableViewCell.h"

static NSInteger const kLineMargin = 45;
static NSInteger const kEventLabelWidth = 35;
static NSInteger const kLeftMargin = 15;
static NSInteger const kRightMargin = 15;

static NSInteger const kLineBackMargin = 10;

@interface ProductSliderTableViewCell()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *lineArr;

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
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    
    self.rightBtn = [[UIButton alloc] init];
    UIPanGestureRecognizer *rightPanGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnPan:)];
    [_rightBtn addGestureRecognizer:rightPanGes];
    _rightBtn.tag = 11;
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

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSource:(NSArray<Model *> *)source {
    _source = source;
    
    _lineArr = [NSMutableArray array];
    _eventArr = [NSMutableArray array];
    
    for (int i = 0; i < source.count; i++) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        [_containerView addSubview:line];
        [_lineArr addObject:line];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.text = source[i].event;
        [_containerView addSubview:label];
        [_eventArr addObject:label];
    }
    
    CGFloat expectWidth = kLeftMargin + kRightMargin + (_source.count - 1) * kLineMargin + kEventLabelWidth;
    CGFloat actualWidth = expectWidth > kScreenWidth ? expectWidth : kScreenWidth;
    
    CGFloat lineMargin = expectWidth > kScreenWidth ? kLineMargin : (kScreenWidth - kLeftMargin - kRightMargin - kEventLabelWidth) * 1.0 / (_source.count - 1);
    
    _backImageView.frame = CGRectMake(kLeftMargin + kEventLabelWidth * 0.5 - kLineBackMargin, 20, actualWidth - 2 * (kLeftMargin + kEventLabelWidth * 0.5) + 2 * kLineBackMargin, 15);
    _frontImageView.frame = _backImageView.frame;
    
    for (int i = 0; i < _lineArr.count; i++) {
        _lineArr[i].frame = CGRectMake(i * lineMargin + kLeftMargin + kEventLabelWidth * 0.5, _backImageView.maxY, 1.5, 20);
    }
    
    for (int i = 0; i < _eventArr.count; i++) {
        _eventArr[i].frame = CGRectMake(kLeftMargin + i * lineMargin, _backImageView.maxY + 20, kEventLabelWidth, 20);
    }
    
    if (_lineArr.count > 0) {
        _backImageView.x = _lineArr[0].centerX - kLineBackMargin;
        _frontImageView.x = _backImageView.x;
        
        _leftBtn.size = CGSizeMake(20, 20);
        _leftBtn.x = _lineArr[0].centerX - _leftBtn.width * 0.5;
        _leftBtn.y = _backImageView.centerY - _leftBtn.height * 0.5;
        
        _rightBtn.x = _lineArr.lastObject.centerX - 10;
    }
    
    _rightBtn.y = _leftBtn.y;
    _rightBtn.size = CGSizeMake(20, 20);
    self.scrollview.contentSize = CGSizeMake(actualWidth, 120);
    self.containerView.frame = CGRectMake(0, 0, actualWidth, 120);
}

#pragma mark - 拖动button

- (void)btnPan:(UIPanGestureRecognizer *)ges {
    
    static CGFloat startMoveButtonX = 0;
    static CGFloat startFrontWidth = 0;
    static CGFloat startFrontX = 0;
    CGPoint location = [ges locationInView:self.containerView];
    
    if (location.x < _backImageView.x + kLineBackMargin || location.x > _backImageView.maxX - kLineBackMargin) {
        return;
    }
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        startMoveButtonX = ges.view.centerX;
        startFrontWidth = self.frontImageView.width;
        startFrontX = self.frontImageView.x;
    }
    
    if (ges.state == UIGestureRecognizerStateEnded) {
        int index = [self indexOfPoint:location.x];
        ges.view.centerX = _lineArr[index].centerX;
        if (ges.view.tag == 10) {
            self.leftSelectedIndex = index;
            if (self.leftSelectedCompletionAction) {
                self.leftSelectedCompletionAction(index);
            }
            
            self.frontImageView.x = ges.view.centerX - kLineBackMargin;
            self.frontImageView.width = startFrontWidth - (self.frontImageView.x - startFrontX);
        } else if (ges.view.tag == 11) {
            self.rightSelectedIndex = index;
            if (self.rightSelectedCompletionAction) {
                self.rightSelectedCompletionAction(index);
            }
            
            self.frontImageView.width = startFrontWidth + (_lineArr[index].centerX - startMoveButtonX);
        }
        
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

@implementation Model

+ (NSArray *)testSource:(NSInteger)count {
    NSMutableArray *marr = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        Model *m = [[Model alloc] init];
        m.event = @"逗比";
        m.date = @"1-1";
        [marr addObject:m];
    }

    return marr;
}

@end
