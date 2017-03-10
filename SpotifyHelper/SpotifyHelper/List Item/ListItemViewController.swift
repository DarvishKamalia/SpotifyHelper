import UIKit

fileprivate struct Constants {
    static let cellIdentifier = "ListItemCell"
}

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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let identifier = item.detailType.cellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ListItemCell else {
            fatalError("Could not create cell for list view controller")
        }
            
        cell.configure(withItem: items[indexPath.row])
        return cell
    }
    
    // MARK: - TableView delegate methods
    
    
    
}
