import Foundation

fileprivate struct Constants {
    static let baseURL = "https://api.spotify.com/v1/me/"
}

/// Handles API calls for the main flow, including fetching user playlist, albums
class MainAPIClient  {
    /// The API access token provided by the Spotify OAuth flow
    let accessToken: String
    
    init (accessToken token: String) {
        self.accessToken = token
    }
    
    
    
    
}
