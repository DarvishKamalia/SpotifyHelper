import Foundation

struct Playlist : ListItem {
    var detailType: ListItemDetailType {
        return .none
    }

    let name: String
    let trackFetchURL: String
    
    // MARK: - ListItem properties 
    
    var titleString: String {
        return name
    }
    
    var subtitleString: String {
        return ""
    }
}
