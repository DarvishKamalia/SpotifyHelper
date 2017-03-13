import Foundation

struct Album : ListItem {
    let name: String
    let artists: [String]
    let albumArtURL: String
    let trackFetchURL: String
    
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
