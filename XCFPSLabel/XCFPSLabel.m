//
//  XCFPSLabel.m
//  FPSLabelDemo
//
//  Created by 樊小聪 on 2017/9/14.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "XCFPSLabel.h"


@interface XCFPSLabel ()
@property (weak, nonatomic) CADisplayLink *link;
@end


@implementation XCFPSLabel
{
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}

- (void)dealloc
{
    [_link invalidate];
}

#pragma mark - 👀 Init Method 👀 💤

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置默认参数
        [self setupDefaults];
    }
    
    return self;
}

// 设置默认参数
- (void)setupDefaults
{
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:.7f];
    _font = [UIFont fontWithName:@"Menlo" size:14];
    _subFont = [UIFont fontWithName:@"Menlo" size:4];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link = link;
}

#pragma mark - 🎬 👀 Action Method 👀

- (void)tick:(CADisplayLink *)link
{
    if (_lastTime == 0)
    {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttributes:@{NSForegroundColorAttributeName: color} range:NSMakeRange(0, text.length - 3)];
    [text addAttributes:@{NSForegroundColorAttributeName: color} range:NSMakeRange(text.length - 3, 3)];
    [text addAttributes:@{NSFontAttributeName: _font} range:NSMakeRange(0, text.length)];
    [text addAttributes:@{NSFontAttributeName: _subFont} range:NSMakeRange(text.length - 4, 1)];
    
    self.attributedText = text;
}

@end
