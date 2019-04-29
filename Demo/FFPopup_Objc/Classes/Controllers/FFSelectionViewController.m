//
//  FFSelectionViewController.m
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFSelectionViewController.h"
#import "FFTableView.h"
#import "FFSelectionTableViewCell.h"
#import "FFPopupModel.h"

@interface FFSelectionViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) FFTableView *tableView;
@property (nonatomic, strong) FFPopupModel *model;
@property (nonatomic, assign) FFSelectionType type;
@property (nonatomic, strong) NSArray<FFItemModel*> *items;
@end

@implementation FFSelectionViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Public Methods
- (void)configureWithType:(FFSelectionType)type model:(FFPopupModel *)model {
    NSString *title = @"";
    switch (type) {
        case FFSelectionType_HorizontalLayout:
            title = model.layout.firstObject.name;
            self.items = model.layout.firstObject.types;
            break;
        case FFSelectionType_VerticalLayout:
            title = model.layout.lastObject.name;
            self.items = model.layout.lastObject.types;
            break;
        case FFSelectionType_ShowAnimation:
            title = model.animation.firstObject.name;
            self.items = model.animation.firstObject.types;
            break;
        case FFSelectionType_DismissAnimation:
            title = model.animation.lastObject.name;
            self.items = model.animation.lastObject.types;
            break;
        case FFSelectionType_Mask:
            title = model.mask.name;
            self.items = model.mask.types;
            break;
        default:
            break;
    }
    self.title = title;
    self.model = model;
    self.type = type;
    [_tableView reloadData];
}

#pragma mark - Private Methods
- (void)setupViews {
    [self.view addSubview:self.tableView];
    // Make constraints
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Custom BackButton
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBarItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)backButtonClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFItemModel *item = _items[indexPath.row];
    FFSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFFSelectionTableViewCell];
    [cell updateTitle:item.title selected:item.selected];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FFSelectionTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (FFItemModel *temp in _items) {
        if (temp.selected) {
            temp.selected = !temp.selected;
            break;
        }
    }
    FFItemModel *item = _items[indexPath.row];
    item.selected = !item.selected;
    [_tableView reloadData];
    
    if (_selectedBlock) {
        _selectedBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor FFLightGray];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

#pragma mark - Properties
- (FFTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FFTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor FFLightGray];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[FFSelectionTableViewCell class] forCellReuseIdentifier:kFFSelectionTableViewCell];
    }
    return _tableView;
}

@end
