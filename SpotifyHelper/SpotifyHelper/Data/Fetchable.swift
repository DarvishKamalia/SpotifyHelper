import Foundation
import SwiftyJSON

/// Conformers can be fetched from endpoints
protocol Fetchable {
    static var fetchEndpoint: String { get }
    init?(withJSON json: JSON)
}

extension Track : Fetchable {
    static var fetchEndpoint = "tracks"
    
    init? (withJSON json: JSON) {
        let json = json["track"].exists() ? json["track"] : json
        guard
            let name = json["name"].string,
            let artists = json["artists"].array?.map({$0["name"].string}).flatMap({$0})
            else {
                print ("error parsing JSON for Track object \(json.rawString())")
                return nil
        }
        
        self.name = name
        self.albumName = json["album"]["name"].string ?? ""
        self.artists = artists
    }
}

extension Album : Fetchable {
    static var fetchEndpoint = "albums"
    
    init? (withJSON json: JSON) {
        let json = json["album"]
        guard
            let name = json["name"].string,
            let artists = json["artists"].array?.map({$0["name"].string }).flatMap({ $0 }),
            let albumArtURL = json["images"].array?[0]["url"].string, // We use the largest image for now
            let trackFetchURL = json["tracks"]["href"].string
            else {
                return nil
        }
        
        self.name = name
        self.artists = artists
        self.albumArtURL = albumArtURL
        self.trackFetchURL = trackFetchURL
    }
}

extension Playlist: Fetchable {
    static var fetchEndpoint = "playlists"
    
    init? (withJSON json: JSON) {
        guard
            let name = json["name"].string,
            let tracksURL = json["tracks"]["href"].string
            else {
                return nil
        }
        
        self.name = name
        self.trackFetchURL = tracksURL
    }
}
