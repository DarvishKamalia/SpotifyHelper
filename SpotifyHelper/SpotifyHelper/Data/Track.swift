import Foundation
import SwiftyJSON

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
    
    init? (withJSON json: JSON) {
        guard
            let name = json["name"].string,
            let albumName = json["album"]["name"].string,
            let albumID = json["album"]["id"].string,
            let artists = json["artists"].array
        else {
            print ("error parsing JSON for Track object \(json.rawString())")
            return nil
        }
        
        self.name = name
        self.albumName = albumName
        self.albumID = albumID
        self.artists = artists.map() { $0["name"].string }.flatMap() { $0 }
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
