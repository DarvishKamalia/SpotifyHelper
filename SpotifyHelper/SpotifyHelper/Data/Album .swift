import Foundation

struct Album : ListItem {
    let name: String
    let artistName: String
    let albumArtURL: String
    
    init(name: String, artistName: String, albumArtURL: String) {
        self.name = name
        self.artistName = artistName
        self.albumArtURL = albumArtURL
    }
    // MARK: - ListItem properties 
    
    var titleString: String {
        return name
    }
    
    var subtitleString: String {
        return artistName
    }
    
    var detailType: ListItemDetailType {
        return .image(imageURL: albumArtURL)
    }
    
}
