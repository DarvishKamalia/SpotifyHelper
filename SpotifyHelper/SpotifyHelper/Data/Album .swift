import Foundation

struct Album : ListItem {
    let name: String
    let artists: [String]
    let albumArtURL: String
    
    // MARK: - Initialization
    
    init(name: String, artists: [String], albumArtURL: String) {
        self.name = name
        self.artists = artists
        self.albumArtURL = albumArtURL
    }
    
    // MARK: - ListItem properties 
    
    var titleString: String {
        return name
    }
    
    var subtitleString: String {
        return artists.joined(separator: ", ")
    }
    
    var detailType: ListItemDetailType {
        return .image(imageURL: albumArtURL)
    }
    
}
