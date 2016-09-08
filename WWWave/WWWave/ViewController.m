//
//  ViewController.m
//  WWWave
//
//  Created by wangwei on 16/9/8.
//  Copyright © 2016年 wangwei-WW. All rights reserved.
//  Github  Demo  : https://github.com/wwpeter/WW-wave

#import "ViewController.h"
#import "WWWaveView.h"

NSString * const TableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// rgb颜色转换（16进制->10进制）
#define KHexColor(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WWWaveView *headerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *totalAssets;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self initViewConfigurations];
}
- (void)initViews {
    [self.view addSubview:self.tableView];
}
- (void)initViewConfigurations {
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCellReuseIdentifier];
    }
    cell.textLabel.text = @"我是iOS开发者王威";
    cell.detailTextLabel.text = @"低调";
    
    return cell;
}
#pragma makr - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma amrk - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (WWWaveView *)headerView{
    
    if (!_headerView) {
        _headerView = [[WWWaveView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerView.backgroundColor = KHexColor(0x00FF7F);
        [_headerView addSubview:self.totalAssets];
        _totalAssets.center = _headerView.center;
        [_headerView addSubview:self.iconImageView];
        [_headerView setCurvature:1.6 speet:0.6 height:8];//外面配置
        
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.iconImageView frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.headerView.waveHeight;
            weakSelf.iconImageView.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}
- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width/2-30, 0, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.image = [UIImage imageNamed:@"ww"];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}
- (UILabel *)totalAssets {
    if (!_totalAssets) {
        _totalAssets = [[UILabel alloc] init];
        _totalAssets.textAlignment = NSTextAlignmentCenter;
        _totalAssets.text = @"总资产：888888888元";
        _totalAssets.textColor = KHexColor(0x8B3A3A);
        _totalAssets.frame = CGRectMake(0, 0, 180, 40);
    }
    return _totalAssets;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
