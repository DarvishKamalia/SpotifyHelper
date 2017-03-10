import UIKit

class MePlaylistAlbumViewController: UITabBarController {
    
    // MARK: - Properties
    
    let client: MainAPIClient
    
    // MARK: - Initialization
    
    init(accessToken: String) {
        client = MainAPIClient(accessToken: accessToken)
        super.init(nibName: nil, bundle: nil)
        
//        client.fetchTracks() { tracks in
//            self.client.fetchAlbums() { albums in
//                let trackVC = ListItemViewController(items: tracks)
//                let albumVC = ListItemViewController(items: albums)
//                self.viewControllers = [trackVC, albumVC]
//                trackVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//                albumVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
//            }
//        }
    
        let trackFetchRequest = FetchRequest<Track>(startIndex: 0, offset: 0)
        
        client.fetch(request: trackFetchRequest) { tracks in
            let trackVC = ListItemViewController(items: tracks)
            self.viewControllers?.append(trackVC)
            trackVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        }
        
        let albumFetchRequest = FetchRequest<Album>(startIndex: 0, offset: 0)
        
        client.fetch(request: albumFetchRequest) { albums in
            let albumVC = ListItemViewController(items: albums)
            self.viewControllers?.append(albumVC)
            albumVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle 
    
    override func viewDidLoad() {
        
    }
}