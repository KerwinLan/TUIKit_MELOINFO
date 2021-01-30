//
//  TUIVoiceMessageCell.m
//  UIKit
//
//  Created by annidyfeng on 2019/5/30.
//

#import "TUIVoiceMessageCell.h"
#import "THeader.h"
#import "TUIKit.h"
#import "MMLayout/UIView+MMLayout.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "Masonry/Masonry.h"


@implementation TUIVoiceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _voice = [[UIImageView alloc] init];
        _voice.animationDuration = 1;
        [self.bubbleView addSubview:_voice];

        _duration = [[UILabel alloc] init];
        _duration.font = [UIFont systemFontOfSize:16];
        _duration.textColor = [UIColor blackColor];
        [self.bubbleView addSubview:_duration];

        _voiceReadPoint = [[UIImageView alloc] init];
        _voiceReadPoint.backgroundColor = [UIColor redColor];
        _voiceReadPoint.hidden = YES;
        [_voiceReadPoint.layer setCornerRadius:4];
        [_voiceReadPoint.layer setMasksToBounds:YES];
        [self.bubbleView addSubview:_voiceReadPoint];
    }
    return self;
}

- (void)fillWithData:(TUIVoiceMessageCellData *)data;
{
    //set data
    [super fillWithData:data];
    self.voiceData = data;
    if (data.duration > 0) {
        _duration.text = [NSString stringWithFormat:@"%ld\"", (long)data.duration];
    } else {
        _duration.text = @"1\"";    // 显示0秒容易产生误解
    }
    _voice.image = data.voiceImage;
    _voice.animationImages = data.voiceAnimationImages;
    
    //voiceReadPoint
    //此处0为语音消息未播放，1为语音消息已播放
    //发送出的消息，不展示红点
    if(self.voiceData.innerMessage.localCustomInt == 0 && self.voiceData.direction == MsgDirectionIncoming)
        self.voiceReadPoint.hidden = NO;

    //animate
    @weakify(self)
    [[RACObserve(data, isPlaying) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSNumber *x) {
        @strongify(self)
        if ([x boolValue]) {
            [self.voice startAnimating];
        } else {
            [self.voice stopAnimating];
        }
    }];
    if (data.direction == MsgDirectionIncoming) {
        _duration.textAlignment = NSTextAlignmentLeft;
    } else {
        _duration.textAlignment = NSTextAlignmentRight;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    if (self.voiceData.direction == MsgDirectionOutgoing) {
        self.voiceReadPoint.hidden = YES;
        [self.voice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bubbleView).with.offset(self.voiceData.voiceTop);
            make.right.equalTo(self.bubbleView).with.offset(-15);
        }];
        [self.duration mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voice);
            make.right.equalTo(self.voice.mas_left).with.offset(-8);
        }];
    } else {
        [self.voice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bubbleView).with.offset(self.voiceData.voiceTop);
            make.left.equalTo(self.bubbleView).with.offset(15);
        }];
        [self.duration mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voice);
            make.left.equalTo(self.voice.mas_right).with.offset(8);
        }];
        [self.voiceReadPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bubbleView.mas_right).with.offset(-4);
            make.centerY.equalTo(self.bubbleView.mas_top).with.offset(4);
            make.width.and.height.mas_equalTo(8);
        }];
    }
}


@end

