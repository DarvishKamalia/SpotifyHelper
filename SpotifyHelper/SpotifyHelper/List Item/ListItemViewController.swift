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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.titleString
        cell.detailTextLabel?.text = item.subtitleString
        
        switch item.detailType {
            case .image(let imageURL): cell.imageView?.image = UIImage(named: imageURL)
            case .none: break
        }
        
        return cell
    }
}
