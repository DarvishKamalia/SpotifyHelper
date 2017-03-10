import Alamofire
import SwiftyJSON

fileprivate struct Constants {
    static let baseURL = "https://api.spotify.com/v1/me/"
    static let tracksEndpoint = "tracks"
    static let albumsEndpoint = "albums"
}

/// Handles API calls for the main flow, including fetching user playlist, albums
class MainAPIClient  {
    /// The API access token provided by the Spotify OAuth flow
    let accessToken: String
    
    init (accessToken token: String) {
        self.accessToken = token
    }
    
    func fetch<T : Fetchable>(request: FetchRequest<T>, completion: @escaping (([T]) -> Void)) {
        Alamofire.request(Constants.baseURL + Constants.tracksEndpoint, method: .get, headers: ["authorization" : "Bearer " + accessToken])
            .response { response in
                if
                    let data = response.data,
                    let jsonResponse = JSON(data: data)["items"].array
                {
                    completion(jsonResponse.map() { T(withJSON: $0) }.flatMap() { $0 })
                }
        }
    }
}

/// A wrapper that holds request metadata 
struct FetchRequest<T : Fetchable> {
    let startIndex: Int
    let offset: Int
}

/// Conformers can be fetched from endpoints 
protocol Fetchable {
    var fetchEndpoint: String { get }
    init?(withJSON json: JSON)
}

extension Track : Fetchable {
    var fetchEndpoint: String {
        return "tracks"
    }
    
    init? (withJSON json: JSON) {
        let json = json["track"] //We ignore the other metadata in the json for now
        guard
            let name = json["name"].string,
            let albumName = json["album"]["name"].string,
            let albumID = json["album"]["id"].string,
            let artists = json["artists"].array?.map({$0["name"].string}).flatMap({$0})
            else {
                print ("error parsing JSON for Track object \(json.rawString())")
                return nil
        }
        
        self.name = name
        self.albumName = albumName
        self.albumID = albumID
        self.artists = artists
    }
}

extension Album : Fetchable {
    var fetchEndpoint: String {
        return "albums"
    }
    
    init? (withJSON json: JSON) {
        guard
            let name = json["name"].string,
            let artists = json["artists"].array?.map({$0["name"].string }).flatMap({ $0 }),
            let albumArtURL = json["images"].array?[0]["url"].string // We use the largest image for now
        else {
                return nil
        }
        
        self.name = name
        self.artists = artists
        self.albumArtURL = albumArtURL
    }
}
