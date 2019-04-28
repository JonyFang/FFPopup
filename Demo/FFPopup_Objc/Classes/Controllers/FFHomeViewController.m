//
//  FFHomeViewController.m
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFHomeViewController.h"
#import "FFSelectionViewController.h"
#import "BLCustomContentView.h"
#import "FFTableView.h"
#import "FFSectionHeader.h"
#import "FFHomeTableViewCell.h"
#import "FFSelectionTableViewCell.h"

#import "YYModel.h"
#import "FFPopupModel.h"
#import "FFPopupHelper.h"

#import <FFPopup/FFPopup.h>

#define K_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define K_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

static const CGFloat kDefaultDismissAfterDuration = 2.0;

@interface FFHomeViewController () <BLCustomContentViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *popupButton;
@property (nonatomic, strong) BLCustomContentView *contentView;
@property (nonatomic, strong) FFTableView *tableView;
@property (nonatomic, strong) FFPopupModel *model;
@end

@implementation FFHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self configureData];
}

#pragma mark - Private Methods
- (void)setupViews {
    self.title = @"FFPopup Example";
    self.view.backgroundColor = [UIColor FFLightGray];
    [self.view addSubview:self.popupButton];
    [self.view addSubview:self.tableView];
    /// Make Constraints
    [_popupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-22);
        make.right.equalTo(self.view.mas_right).offset(-44);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.height.mas_equalTo(44);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.popupButton.mas_top).offset(-22);
    }];
}

- (void)configureData {
    FFPopupModel *model = [FFPopupModel yy_modelWithJSON:[FFPopupHelper readLocalFileWithName:@"default"][@"data"]];
    self.model = model;
    [_tableView reloadData];
}

- (void)popupButtonClicked:(UIButton *)button {
    FFPopupHorizontalLayout horizontalLayout = FFPopupHorizontalLayout_Center;
    FFPopupVerticalLayout verticalLayout = FFPopupVerticalLayout_Center;
    FFPopupShowType showType = FFPopupShowType_BounceInFromTop;
    FFPopupDismissType dismissType = FFPopupDismissType_BounceOutToBottom;
    FFPopupMaskType maskType = FFPopupMaskType_Dimmed;
    BOOL shouldDismissOnBackgroundTouch = YES;
    BOOL shouldDismissOnContentTouch = NO;
    BOOL shouldDismissOutAfterDuration = NO;
    
    ///Layout
    for (FFItemModel *item in _model.layout.firstObject.types) {
        if (item.selected) {
            horizontalLayout = item.type;
            break;
        }
    }
    for (FFItemModel *item in _model.layout.lastObject.types) {
        if (item.selected) {
            verticalLayout = item.type;
            break;
        }
    }
    FFPopupLayout layout = FFPopupLayoutMake(horizontalLayout, verticalLayout);
    ///Animation
    for (FFItemModel *item in _model.animation.firstObject.types) {
        if (item.selected) {
            showType = item.type;
            break;
        }
    }
    for (FFItemModel *item in _model.animation.lastObject.types) {
        if (item.selected) {
            dismissType = item.type;
            break;
        }
    }
    ///Mask
    for (FFItemModel *item in _model.mask.types) {
        if (item.selected) {
            maskType = item.type;
            break;
        }
    }
    ///Whether dismiss popup when background is touched.
    shouldDismissOnBackgroundTouch = _model.background.enable;
    ///Whether dismiss popup when content is touched.
    shouldDismissOnContentTouch = _model.content.enable;
    ///Whether dismiss popup after duration.
    shouldDismissOutAfterDuration = _model.duration.enable;
    
    ///Configure popup & pop it.
    FFPopup *popup = [FFPopup popupWithContentView:self.contentView];
    popup.showType = showType;
    popup.dismissType = dismissType;
    popup.maskType = maskType;
    popup.shouldDismissOnBackgroundTouch = shouldDismissOnBackgroundTouch;
    popup.shouldDismissOnContentTouch = shouldDismissOnContentTouch;
    [popup showWithLayout:layout duration:shouldDismissOutAfterDuration ? kDefaultDismissAfterDuration : 0.0];
}

#pragma mark - BLCustomContentViewDelegate
- (void)didClickedCloseButton:(UIButton *)button {
    [FFPopup dismissSuperPopupIn:button animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? _model.layout.count : (section == 1 ? _model.animation.count : 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            FFStateItemModel *itemModel = _model.layout[indexPath.row];
            FFItemModel *item;
            for (FFItemModel *temp in itemModel.types) {
                if (temp.selected) {
                    item = temp;
                    break;
                }
            }
            FFHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFHomeTableViewCell];
            [cell updateTitle:itemModel.name subtitle:item.title];
            return cell;
        }   break;
        case 1: {
            FFStateItemModel *itemModel = _model.animation[indexPath.row];
            FFItemModel *item = [FFItemModel new];
            for (FFItemModel *temp in itemModel.types) {
                if (temp.selected) {
                    item = temp;
                    break;
                }
            }
            FFHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFHomeTableViewCell];
            [cell updateTitle:itemModel.name subtitle:item.title];
            return cell;
        }   break;
        case 2: {
            FFStateItemModel *itemModel = _model.mask;
            FFItemModel *item = [FFItemModel new];
            for (FFItemModel *temp in itemModel.types) {
                if (temp.selected) {
                    item = temp;
                    break;
                }
            }
            FFHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFHomeTableViewCell];
            [cell updateTitle:itemModel.name subtitle:item.title];
            return cell;
        }   break;
        case 3: {
            FFActionItemModel *itemModel = _model.background;
            FFSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFSelectionTableViewCell];
            [cell updateTitle:itemModel.name selected:itemModel.enable];
            return cell;
        }   break;
        case 4: {
            FFActionItemModel *itemModel = _model.content;
            FFSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFSelectionTableViewCell];
            [cell updateTitle:itemModel.name selected:itemModel.enable];
            return cell;
        }   break;
        case 5: {
            FFActionItemModel *itemModel = _model.duration;
            FFSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFSelectionTableViewCell];
            [cell updateTitle:itemModel.name selected:itemModel.enable];
            return cell;
        }   break;
        default:
            return UITableViewCell.new;
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FFSelectionType type = FFSelectionType_None;
    switch (indexPath.section) {
        case 0:
            type = indexPath.row == 0 ? FFSelectionType_HorizontalLayout : FFSelectionType_VerticalLayout;
            break;
        case 1:
            type = indexPath.row == 0 ? FFSelectionType_ShowAnimation : FFSelectionType_DismissAnimation;
            break;
        case 2:
            type = FFSelectionType_Mask;
            break;
        case 3: {
            _model.background.enable = !_model.background.enable;
            [_tableView reloadData];
            return;
        }   break;
        case 4: {
            _model.content.enable = !_model.content.enable;
            [_tableView reloadData];
            return;
        }   break;
        case 5: {
            _model.duration.enable = !_model.duration.enable;
            [_tableView reloadData];
            return;
        }   break;
        default:
            break;
    }
    FFSelectionViewController *vc = [FFSelectionViewController new];
    [vc configureWithType:type model:_model];
    __weak typeof(self) weakSelf = self;
    vc.selectedBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        });
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FFHomeTableViewCell height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFSectionHeader *header = [[FFSectionHeader alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, [FFSectionHeader height])];
    NSString *title = @"";
    switch (section) {
        case 0:
            title = @"Layout";
            break;
        case 1:
            title = @"Animation";
            break;
        case 2:
            title = @"Mask";
            break;
        case 3:
            title = @"Background";
            break;
        case 4:
            title = @"Content";
            break;
        case 5:
            title = @"Duration";
            break;
        default:
            break;
    }
    [header updateTitle:title];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [FFSectionHeader height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

#pragma mark - Properties
- (UIButton *)popupButton {
    if (!_popupButton) {
        _popupButton = [UIButton new];
        _popupButton.backgroundColor = UIColor.FFBlue;
        _popupButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [_popupButton setTitle:@"Show Popup" forState:UIControlStateNormal];
        [_popupButton addTarget:self action:@selector(popupButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _popupButton.layer.cornerRadius = 22;
        _popupButton.layer.masksToBounds = YES;
    }
    return _popupButton;
}

- (BLCustomContentView *)contentView {
    if (!_contentView) {
        CGFloat scale = 375.0 / K_SCREEN_WIDTH;
        CGFloat width = 320.0 * scale;
        CGFloat height = 360.0 * scale;
        _contentView = [[BLCustomContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [_contentView updateTitle:@"👋\nHurray!" desc:@"Your request has been sent successfully. We will email you shortly. Meantime, check our marketing tips on Twitter and Facebook." buttonTitle:@"Got it"];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (FFTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FFTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor FFLightGray];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[FFHomeTableViewCell class] forCellReuseIdentifier:kFFHomeTableViewCell];
        [_tableView registerClass:[FFSelectionTableViewCell class] forCellReuseIdentifier:kFFSelectionTableViewCell];
    }
    return _tableView;
}

@end
