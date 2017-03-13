import Foundation

/// Holds information for a track (song)
struct Track : ListItem {
    
    // MARK: - Properties
    
    let name: String
    let albumName: String
    let artists: [String]
    
    // MARK: - ListItem Properties 
    
    var titleString: String {
        return name
    }
    
    var subtitleString: String {
        return albumName + " - " + artists.joined(separator: ", ")
    }
    
    var detailType: ListItemDetailType {
        return .none
    }
}
