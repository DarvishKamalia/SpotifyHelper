import UIKit
import Alamofire

struct LoginAPIClient {
    static func login() {
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
