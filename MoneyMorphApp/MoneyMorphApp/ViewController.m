//
//  ViewController.m
//  MoneyMorphApp
//
//  Created by Mert Özcan on 24.05.2024.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Optional: Register a default UITableViewCell class for reuse
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (IBAction)buttonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
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

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = YES;
    
    double inputValue = [self.inputField.text doubleValue];
    
        // Update the data array with the new values
    self.data = @[
            [NSString stringWithFormat:@"%.2f EUR", inputValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", inputValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", inputValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", inputValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", inputValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", inputValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", inputValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", inputValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", inputValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", inputValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", inputValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", inputValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", inputValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", inputValue * currencies.TRY]
        ];
        
        // Reload the table view to reflect the updated data
        [self.tableView reloadData];
}

@end
