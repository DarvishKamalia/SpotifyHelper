import Foundation

/// Conformers can be displayed inside a ListItemViewController
protocol ListItem {
    var titleString: String { get }
    var subtitleString: String { get }
    var detailType: ListItemDetailType { get }
}

/// Defines what kind of cell to use to diplay the item. Currently, only image detail types are supported 
enum ListItemDetailType {
    case none
    case image (imageURL: String)
    
    var cellIdentifier: String {
        switch (self) {
            case .none: return "listItemCellStandard"
            case .image: return "listItemCellImage"
        }
    }
}
