import Alamofire
import SwiftyJSON

fileprivate struct Constants {
    static let baseURL = "https://api.spotify.com/v1/"
}

/// Handles API calls for the main flow, including fetching user playlist, albums
class MainAPIClient : RequestAdapter  {
    /// The API access token provided by the Spotify OAuth flow
    let accessToken: String
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        return SessionManager(configuration: configuration)
    }()
    
    init (accessToken token: String) {
        self.accessToken = token
        manager.adapter = self
    }
    
    /// Performs a fetch of the requested type of data 
    /// - paramater request: An object that specifies the type of the page, and optionally provides pagination data
    /// - parameter user: The user ID of the target user whose data is being requested, if none is provided, the method uses the current user by default
    /// - parameter completion: Completion handler called if the request succeeds
    func fetch<T : Fetchable>(request: FetchRequest<T>, completion: @escaping (([T]) -> Void)) {
        manager.request(
            request.url,
            parameters: ["offset" : request.offset],
            encoding: URLEncoding.queryString
        )
        .validate()
        .response
            { response in
                if
                    let data = response.data,
                    let jsonResponse = JSON(data: data)["items"].array
                {
                    completion(jsonResponse.map() { T(withJSON: $0) }.flatMap() { $0 })
                }
            }
    }
    
    /// Returns an adapter with HTTP authorization header
    func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

/// A wrapper that holds request metadata 
struct FetchRequest<T : Fetchable> {
    // Can be used for paginated fetches
    let limit: Int
    let offset: Int
    let url : String 
    
    init (limit: Int = 0, offset: Int = 0, forOtherUser user: String? = nil, withURL fullURL: String? = nil) {
        self.limit = limit
        self.offset = offset
        
        if let url = fullURL {
            self.url = url
        }
        else {
            var url = Constants.baseURL
            
            if let userID = user {
                url += "users/" + userID + "/"
            }
            else {
                url += "me/"
            }
            
            url += T.fetchEndpoint
            self.url = url
        }
    }
}
