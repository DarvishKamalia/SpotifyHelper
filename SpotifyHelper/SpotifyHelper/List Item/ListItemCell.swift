import UIKit

/// Subclasses can display inside ListItemViewControllers
class ListItemCell : UITableViewCell {
    func configure(withItem item: ListItem) {
        fatalError("ListItemCell subclasses must override configure()")
    }
}
