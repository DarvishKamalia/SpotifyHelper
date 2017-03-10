import UIKit

class MePlaylistAlbumViewController: UITabBarController {
    
    // MARK: - Properties
    
    let client: MainAPIClient
    
    // MARK: - Initialization
    
    init(accessToken: String) {
        client = MainAPIClient(accessToken: accessToken)
        super.init(nibName: nil, bundle: nil)
        
        client.fetchTracks() { tracks in
            self.client.fetchAlbums() { albums in
                let trackVC = ListItemViewController(items: tracks)
                let albumVC = ListItemViewController(items: albums)
                self.viewControllers = [trackVC, albumVC]
                trackVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
                albumVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle 
    
    override func viewDidLoad() {
        
    }
}
