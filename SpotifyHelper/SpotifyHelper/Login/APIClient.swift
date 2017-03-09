import UIKit
import Alamofire

fileprivate struct Constants {
    static let SpotifyClientID = "2511cf4d39ac4cb4b1b5d4e002893f0b"
    static let SpotifyClientSecret = "2511cf4d39ac4cb4b1b5d4e002893f0b"
    static let authenticationURL = "https://accounts.spotify.com/authorize"
}

/// Handles calls to the Spotify API. Should be used as a singleton since it needs
/// to preserve state, including
class APIClient {
    static let shared = APIClient()
    
    private init() {
        print ("Initialized")
    }
    
    func login() {
        var components = URLComponents(string: Constants.authenticationURL)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.SpotifyClientID),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "redirect_uri", value: "DropsSpotifyHelper://")
        ]
        
        if let url = components?.url {
            UIApplication.shared.open(url)
        }
    }
}
