import Foundation

/// Holds information for a track (song)
struct Track : ListItem {
    
    // MARK: - Properties
    
    let name: String
    let albumName: String
    let artists: [String]
    let albumID: String
    
    // MARK: - Initialization 
    
    init (name: String, albumName: String, artists: [String], albumID: String) {
        self.name = name
        self.albumName = albumName
        self.artists = artists
        self.albumID = albumID
    }
    
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
