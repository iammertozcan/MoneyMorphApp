//
//  ViewController.m
//  MoneyMorphApp
//
//  Created by Mert Özcan on 24.05.2024.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"0.0 EUR", @"0.0 JPY", @"0.0 BGN", @"0.0 CZK", @"0.0 DKK", @"0.0 GBP", @"0.0 HUF", @"0.0 PLN", @"0.0 RON", @"0.0 SEK", @"0.0 CHF", @"0.0 INR", @"0.0 MXN"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Optional: Register a default UITableViewCell class for reuse
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

// UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Bold" size:15.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row: %ld", (long)indexPath.row);
}

@end
