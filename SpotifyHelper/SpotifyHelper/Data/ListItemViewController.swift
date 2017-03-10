import UIKit

class ListItemViewController: UITableViewController {
    
    // MARK: - Properties 
    
    let items: [ListItem]
    
    // MARK: - Initialization 
    
    init (items: [ListItem]) {
        self.items = items
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TableView data source methods 
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    // MARK: - TableView delegeate methods 
    
    
    
}
