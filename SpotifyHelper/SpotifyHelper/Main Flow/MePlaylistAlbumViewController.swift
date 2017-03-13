import UIKit

class MePlaylistAlbumViewController: UITabBarController, ListItemViewControllerDelegate {
    
    // MARK: - Properties
    
    let client: MainAPIClient
    var albumVC: ListItemViewController!
    var tracksVC: ListItemViewController!
    
    // MARK: - Initialization
    
    init(accessToken: String) {
        client = MainAPIClient(accessToken: accessToken)
        super.init(nibName: nil, bundle: nil)
        
        let trackFetchRequest = FetchRequest<Track>()
        
        client.fetch(request: trackFetchRequest) { tracks in
            self.tracksVC = ListItemViewController(items: tracks)
            self.tracksVC.delegate = self
            self.tracksVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            
            let albumFetchRequest = FetchRequest<Album>()
            
            self.client.fetch(request: albumFetchRequest) { albums in
                self.albumVC = ListItemViewController(items: albums)
                self.albumVC.delegate = self
                self.albumVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
                self.viewControllers = [self.tracksVC, self.albumVC]
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle 
    
    override func viewDidLoad() {
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(MePlaylistAlbumViewController.searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - Actions 
    
    func searchButtonTapped() {
        let alert = UIAlertController(title: "User Search", message: "Enter a user ID to search playlists", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "User ID"
        }
        alert.addAction(
            UIAlertAction(
                title: "Submit",
                style: .default,
                handler: { _ in
                    if let searchText = alert.textFields?.first?.text {
                        let request = FetchRequest<Playlist>(limit: 0, offset: 0, forOtherUser: searchText)
                        self.client.fetch(request: request) { playlists in
                            let playlistVC = ListItemViewController(items: playlists)
                            self.show(playlistVC, sender: nil)
                        }
                    }
                }
            )
        )
            
        alert.dismiss(animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - ListItemViewController delegate methods 
    
    func list(didSelectItem item: ListItem) {
        if let album =  item as? Album {
            let request = FetchRequest<Track>(withURL: album.trackFetchURL)
            client.fetch(request: request, completion: { items in
                self.showList(forItems: items)
            })
        }
        else if let playlist = item as? Playlist {
            let request = FetchRequest<Track>(withURL: playlist.trackFetchURL)
            client.fetch(request: request, completion: { items in
                self.showList(forItems: items)
            })
        }
    }
    
    func list(didScrollToBottom vc: ListItemViewController) {
        if vc == tracksVC {
            let request = FetchRequest<Track>(offset: vc.items.count)
            vc.startBottomSpinner()
            client.fetch(request: request) { tracks in
                vc.add(items: tracks)
                vc.stopBottomSpinner()
            }
        }
        else if vc == albumVC {
            let request = FetchRequest<Album>(offset: vc.items.count)
            vc.startBottomSpinner()
            client.fetch(request: request) { albums in
                vc.add(items: albums)
                vc.stopBottomSpinner()
            }
        }
    }
    
    // MARK: - Private helpers 
    func showList(forItems items: [ListItem]) {
        let listVC = ListItemViewController(items: items)
        listVC.delegate = self
        self.show(listVC, sender: nil)
    }
}
