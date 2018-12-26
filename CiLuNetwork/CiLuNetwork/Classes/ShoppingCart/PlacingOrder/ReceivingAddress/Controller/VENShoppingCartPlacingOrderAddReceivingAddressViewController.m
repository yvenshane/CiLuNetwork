//
//  VENShoppingCartPlacingOrderAddReceivingAddressViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/24.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartPlacingOrderAddReceivingAddressViewController.h"
#import "VENShoppingCartPlacingOrderReceivingAddAddressTableViewCell.h"

@interface VENShoppingCartPlacingOrderAddReceivingAddressViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENShoppingCartPlacingOrderAddReceivingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.isEdit ? @"编辑收货地址" : @"新增收货地址";
    
    [self setupTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        NSLog(@"所在区域");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 3 ? 64 : 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENShoppingCartPlacingOrderReceivingAddAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"联系人";
        cell.rightTextField.placeholder = @"请填写联系人姓名";
    } else if (indexPath.row == 1) {
        cell.leftLabel.text = @"手机号码";
        cell.rightTextField.placeholder = @"请填写联系人手机号";
    } else if (indexPath.row == 2) {
        cell.leftLabel.text = @"所在区域";
        cell.rightTextField.placeholder = @"请选择所在区域";
    } else if (indexPath.row == 3) {
        cell.leftLabel.text = @"详细地址";
    }
    
    cell.rightTextField.hidden = indexPath.row == 3 ? YES : NO;
    cell.rightTextView.hidden = indexPath.row == 3 ? NO : YES;
    
    cell.rightTextField.userInteractionEnabled = indexPath.row == 2 ? NO : YES;
    cell.rightImageView.hidden = indexPath.row == 2 ? NO : YES;
    
    if (indexPath.row == 3) {
        if (self.placeholderLabel == nil) {
            cell.rightTextView.delegate = self;
            
            UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 15, kMainScreenWidth - 103 - 15, 17)];
            placeholderLabel.text = @"请填写详细地址";
            placeholderLabel.font = [UIFont systemFontOfSize:14.0f];
            placeholderLabel.textColor = UIColorFromRGB(0xCCCCCC);
            [cell.contentView addSubview:placeholderLabel];
            
            _placeholderLabel = placeholderLabel;
        }
    }
    
    return cell;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.markedTextRange == nil) {
        self.placeholderLabel.hidden = textView.text.length > 0 ? YES : NO;
    }
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartPlacingOrderReceivingAddAddressTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    // 分割线
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    headerView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.tableHeaderView = headerView;
    
    /**
     默认地址
     保存
     */
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 63 + 48)];
    tableView.tableFooterView = footerView;
    
    UIButton *defaultAddressButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 130, 63)];
    [defaultAddressButton setTitle:@"    默认地址" forState:UIControlStateNormal];
    [defaultAddressButton setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    [defaultAddressButton setImage:[UIImage imageNamed:@"icon_selecte_not"] forState:UIControlStateNormal];
    [defaultAddressButton setImage:[UIImage imageNamed:@"icon_selecte"] forState:UIControlStateSelected];
    defaultAddressButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [defaultAddressButton addTarget:self action:@selector(defaultAddressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:defaultAddressButton];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 63, kMainScreenWidth - 30, 48)];
    saveButton.backgroundColor = COLOR_THEME;
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    saveButton.layer.cornerRadius = 4.0f;
    saveButton.layer.masksToBounds = YES;
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:saveButton];
}

- (void)saveButtonClick {
    NSLog(@"保存");
}

- (void)defaultAddressButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
