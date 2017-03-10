import UIKit

class MePlaylistAlbumViewController: UIViewController {
    
    // MARK: - Properties
    
    let client: MainAPIClient
    
    let tableView: UITableView
    
    // MARK: - Initialization
    
    init(accessToken: String) {
        client = MainAPIClient(accessToken: accessToken)
        tableView = UITableView(frame: .zero, style: .grouped)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle 
    
    override func viewDidLoad() {
        
    }
    
    
}
