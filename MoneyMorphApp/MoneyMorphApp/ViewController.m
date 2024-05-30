//
//  ViewController.m
//  MoneyMorphApp
//
//  Created by Mert Özcan on 24.05.2024.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"
#import "ActionSheetPicker-3.0/ActionSheetStringPicker.h"
@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *selectedCurrency;
@property (strong, nonatomic) NSDictionary *currencySymbols;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[@"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    
    self.currencySymbols = @{
        @"USD (US Dollar)": @"$",
        @"EUR (Euro)": @"€",
        @"JPY (Yen)": @"¥",
        @"BGN (Bulgarian Lev)": @"лв",
        @"CZK (Czech Koruna)": @"Kč",
        @"DKK (Danish Krone)": @"kr",
        @"GBP (Pound Sterling)": @"£",
        @"HUF (Forint)": @"Ft",
        @"PLN (Zloty)": @"zł",
        @"RON (Romanian Leu)": @"lei",
        @"SEK (Swedish Krona)": @"kr",
        @"CHF (Swiss Franc)": @"CHF",
        @"INR (Indian Rupee)": @"₹",
        @"MXN (Mexican Peso)": @"$",
        @"TRY (Turkish Lira)": @"₺"
    };
    
    self.selectedCurrency = @"USD (US Dollar)";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.currencyButton setTitle:self.currencySymbols[self.selectedCurrency] forState:UIControlStateNormal];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (IBAction)buttonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
}

- (IBAction)deleteButtonTapped:(id)sender {
    self.inputField.text = @""; // Clear the text in the input field
    if ([self.selectedCurrency isEqualToString:@"USD (US Dollar)"]) {
        self.data = @[@"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"EUR (Euro)"]) {
        self.data = @[@"0.00 USD", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"JPY (Yen)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"BGN (Bulgarian Lev)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"CZK (Czech Koruna)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"DKK (Danish Krone)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"GBP (Pound Sterling)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"HUF (Forint)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"PLN (Zloty)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"RON (Romanian Leu)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"SEK (Swedish Krona)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 CHF", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"CHF (Swiss Franc)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 INR", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"INR (Indian Rupee)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 MXN", @"0.00 TRY"];
    } else if ([self.selectedCurrency isEqualToString:@"MXN (Mexican Peso)"]) {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 TRY"];
    } else {
        self.data = @[@"0.00 USD", @"0.00 EUR", @"0.00 JPY", @"0.00 BGN", @"0.00 CZK", @"0.00 DKK", @"0.00 GBP", @"0.00 HUF", @"0.00 PLN", @"0.00 RON", @"0.00 SEK", @"0.00 CHF", @"0.00 INR", @"0.00 MXN"];
    }
    
    self.deleteButton.enabled = YES;
    [self.tableView reloadData];
}

- (IBAction)currencyButtonTapped:(id)sender {
    NSArray *currencies = [self.currencySymbols allKeys];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Currency"
                                            rows:currencies
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        NSString *selectedCurrency = currencies[selectedIndex];
        self.selectedCurrency = selectedCurrency;
        NSString *currencySymbol = self.currencySymbols[selectedCurrency];
        [self.currencyButton setTitle:currencySymbol forState:UIControlStateNormal];
        [self updateInputFieldPlaceholder]; // Update the input field's placeholder
        NSLog(@"Selected currency: %@", selectedCurrency);
    }
                                     cancelBlock:nil
                                          origin:sender];
}

- (void)updateInputFieldPlaceholder {
    NSString *currency = self.selectedCurrency;
    NSString *currencyName = [currency componentsSeparatedByString:@""].firstObject;
    
    self.inputField.placeholder = [NSString stringWithFormat:@"%@", currencyName];
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
    double tempValue = 0.0;
    
    // Update the data array with the new values
    if ([self.selectedCurrency isEqualToString:@"USD (US Dollar)"]) {
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
    } else if ([self.selectedCurrency isEqualToString:@"EUR (Euro)"]) {
        tempValue = inputValue / currencies.EUR;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"JPY (Yen)"]) {
        tempValue = inputValue / currencies.JPY;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"BGN (Bulgarian Lev)"]) {
        tempValue = inputValue / currencies.BGN;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"CZK (Czech Koruna)"]) {
        tempValue = inputValue / currencies.CZK;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"DKK (Danish Krone)"]) {
        tempValue = inputValue / currencies.DKK;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"GBP (Pound Sterling)"]) {
        tempValue = inputValue / currencies.GBP;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"HUF (Forint)"]) {
        tempValue = inputValue / currencies.HUF;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"PLN (Zloty)"]) {
        tempValue = inputValue / currencies.PLN;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"RON (Romanian Leu)"]) {
        tempValue = inputValue / currencies.RON;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"SEK (Swedish Krona)"]) {
        tempValue = inputValue / currencies.SEK;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"CHF (Swiss Franc)"]) {
        tempValue = inputValue / currencies.CHF;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"INR (Indian Rupee)"]) {
        tempValue = inputValue / currencies.INR;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"MXN (Mexican Peso)"]) {
        tempValue = inputValue / currencies.MXN;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f TRY", tempValue * currencies.TRY]
        ];
    } else if ([self.selectedCurrency isEqualToString:@"TRY (Turkish Lira)"]) {
        tempValue = inputValue / currencies.TRY;
        self.data = @[
            [NSString stringWithFormat:@"%.2f USD", tempValue * currencies.USD],
            [NSString stringWithFormat:@"%.2f EUR", tempValue * currencies.EUR],
            [NSString stringWithFormat:@"%.2f JPY", tempValue * currencies.JPY],
            [NSString stringWithFormat:@"%.2f BGN", tempValue * currencies.BGN],
            [NSString stringWithFormat:@"%.2f CZK", tempValue * currencies.CZK],
            [NSString stringWithFormat:@"%.2f DKK", tempValue * currencies.DKK],
            [NSString stringWithFormat:@"%.2f GBP", tempValue * currencies.GBP],
            [NSString stringWithFormat:@"%.2f HUF", tempValue * currencies.HUF],
            [NSString stringWithFormat:@"%.2f PLN", tempValue * currencies.PLN],
            [NSString stringWithFormat:@"%.2f RON", tempValue * currencies.RON],
            [NSString stringWithFormat:@"%.2f SEK", tempValue * currencies.SEK],
            [NSString stringWithFormat:@"%.2f CHF", tempValue * currencies.CHF],
            [NSString stringWithFormat:@"%.2f INR", tempValue * currencies.INR],
            [NSString stringWithFormat:@"%.2f MXN", tempValue * currencies.MXN]
        ];
    }
    
    // Reload the table view to reflect the updated data
    [self.tableView reloadData];
}

@end
