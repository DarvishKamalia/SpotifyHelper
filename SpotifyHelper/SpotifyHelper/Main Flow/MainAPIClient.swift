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
    
    func fetchTracks(completion: @escaping ([Track]) -> Void) {
        Alamofire.request(Constants.baseURL + Constants.albumsEndpoint, method: .get, headers: ["authorization" : accessToken])
            .response { response in
                if
                    let data = response.data,
                    let jsonResponse = JSON(data: data).array
                {
                    completion(jsonResponse.map() { Track(withJSON: $0) }.flatMap() { $0 })
                }
            }
    }
    
    func fetchAlbums(completion: ([Album]) -> Void ) {
        let albums = Array(repeating: Album(name: "Test Album", artistName: "Test Artist", albumArtURL: "TestURL"), count: 10)
        completion(albums)
    }
    
}
