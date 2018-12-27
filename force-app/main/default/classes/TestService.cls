public class TestService {
    
    public static TestService getInstance() {
        return new TestService();
    }
	
    public void setup() {
        
        // Create new products
        Product2 simpleSpinner = new Product2(
            ProductCode = 'SPIN-001',
            IsActive = true,
            Name = 'Simple Spinner'
        );
        
        Product2 flashingSpinner = new Product2(
            ProductCode = 'SPIN-002',
            IsActive = true,
            Name = 'Flashing Spinner'
        );
        
        List<Product2> newProducts = new List<Product2>();
        newProducts.add(simpleSpinner);
        newProducts.add(flashingSpinner);
        insert newProducts;
        
        // Create new price books
        Pricebook2 twentynineteenPricebook = new Pricebook2(
            IsActive = true,
            Name = '2019 Price Book'
        );
        
        insert twentynineteenPricebook;
        
        // Get the standard price book
        Pricebook2 standardPricebook = [
            SELECT Id
            FROM Pricebook2
            WHERE IsStandard = TRUE
        ];
        
        // Create new price book entries
        List<PricebookEntry> newEntries = new List<PricebookEntry>();
        newEntries.add(new PricebookEntry(
            IsActive = true,
            Pricebook2Id = standardPricebook.Id,
            Product2Id = simpleSpinner.Id,
            UnitPrice = 5.00
        ));
        newEntries.add(new PricebookEntry(
            IsActive = true,
            Pricebook2Id = standardPricebook.Id,
            Product2Id = flashingSpinner.Id,
            UnitPrice = 8.00
        ));
        newEntries.add(new PricebookEntry(
            IsActive = true,
            Pricebook2Id = twentynineteenPricebook.Id,
            Product2Id = simpleSpinner.Id,
            UnitPrice = 4.50
        ));
        newEntries.add(new PricebookEntry(
            IsActive = true,
            Pricebook2Id = twentynineteenPricebook.Id,
            Product2Id = flashingSpinner.Id,
            UnitPrice = 7.50
        ));
        insert newEntries;
    }
}