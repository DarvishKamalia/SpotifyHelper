import UIKit
import SDWebImage

fileprivate struct Constants {
    static let cellIdentifier = "ListItemCell"
}

protocol ListItemViewControllerDelegate {
    mutating func list(didScrollToBottom vc: ListItemViewController)
    func list(didSelectItem item: ListItem)
}

class ListItemViewController: UITableViewController {
    
    // MARK: - Properties 
    
    var items: [ListItem] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func add(items: [ListItem]) {
        self.items += items
    }
    
    var delegate: ListItemViewControllerDelegate? = nil
    
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
        cell.textLabel?.font = UIFont(name: "Avenir", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Avenir-Light", size: 12)
        
        switch item.detailType {
            case .image(let imageURL):
                let url = URL(string: imageURL)
                cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "warning")) // Use a random asset for placeholder for now
            case .none:
                break
        }
        
        return cell
    }
    
    // MARK: - TableView delegate methods 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.list(didSelectItem: items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Scrolling 
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Check if we are scrolled to the bottom, and load more rows if required
        let offset:CGPoint = scrollView.contentOffset
        let bounds:CGRect = scrollView.bounds
        let size:CGSize = scrollView.contentSize
        let inset:UIEdgeInsets = scrollView.contentInset
        let y:CGFloat = offset.y + bounds.size.height - inset.bottom
        let h:CGFloat = size.height
        let reload_distance:CGFloat = 10
        if(y > h + reload_distance) {
            delegate?.list(didScrollToBottom: self)
        }
    }
    
    // MARK: - Helpers
    
    func startBottomSpinner() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.tableFooterView = spinner
        spinner.startAnimating()
    }
    
    func stopBottomSpinner() {
        tableView.tableFooterView = nil
    }
}
