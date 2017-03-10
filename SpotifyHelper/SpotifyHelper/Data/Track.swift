import Foundation
import SwiftyJSON

/// Holds information for a track (song)
struct Track : ListItem {
    
    // MARK: - Properties
    
    let name: String
    let albumName: String
    let artistName: String
    let albumID: String
    
    // MARK: - Initialization 
    
    init (name: String, albumName: String, artistName: String, albumID: String) {
        self.name = name
        self.albumName = albumName
        self.artistName = artistName
        self.albumID = albumID
    }
    
    // MARK: - ListItem Properties 
    
    var titleString: String {
        return name
    }
    
    var subtitleString: String {
        return albumName + " - " + artistName
    }
    
    var detailType: ListItemDetailType {
        return .none
    }
}
