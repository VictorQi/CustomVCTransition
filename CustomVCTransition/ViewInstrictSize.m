//
//  ViewInstrictSize.m
//  CustomVCTransition
//
//  Created by Victor on 16/8/11.
//  Copyright © 2016年 victor. All rights reserved.
//

#import "ViewInstrictSize.h"
#import "Masonry.h"

@interface ViewInstrictSize ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewInstrictSize

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.label = ({
            UILabel *lab = [UILabel new];
            lab.font = [UIFont systemFontOfSize:15];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor redColor];
            lab.numberOfLines = 0;
            [self addSubview:lab];
            
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(20);
                make.leading.equalTo(self.mas_leading).offset(20);
                make.trailing.equalTo(self.mas_trailing).offset(-20);
            }];
        
            lab;
        });
        
        self.imgView = ({
            UIImageView *imgv = [UIImageView new];
            [self addSubview:imgv];
            
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.label.mas_baseline).offset(30);
                make.leading.greaterThanOrEqualTo(self.label.mas_leading).offset(20);
                make.centerX.equalTo(self.mas_centerX);
                make.bottom.equalTo(self.mas_bottom).offset(-30);
            }];
            
            imgv;
        });
        
        self.layer.cornerRadius = 9.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setImage:(UIImage *)image {
    [self willChangeValueForKey:@"image"];
    self.imgView.image = image;
    [self didChangeValueForKey:@"image"];
}

- (void)setText:(NSString *)text {
    [self willChangeValueForKey:@"text"];
    self.label.text = text;
    [self didChangeValueForKey:@"text"];
}

@end
