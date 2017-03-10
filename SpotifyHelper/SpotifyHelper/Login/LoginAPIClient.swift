import UIKit
import Alamofire

/// Handles calls to the Spotify API. Should be used as a singleton since it needs
/// to preserve state, including
class LoginAPIClient {
    func login() {
        var components = URLComponents(string: "https://accounts.spotify.com/authorize")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: "2511cf4d39ac4cb4b1b5d4e002893f0b"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "redirect_uri", value: "DropsSpotifyHelper://"),
            URLQueryItem(name: "scope", value: "user-library-read user-top-read")
        ]
        
        if let url = components?.url {
            UIApplication.shared.open(url)
        }
    }
}
