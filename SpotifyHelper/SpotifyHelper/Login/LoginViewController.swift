import UIKit

/// Handles login input and validation
class LoginViewController: UIViewController {
   
    // MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions 
    
    @IBAction func loginButton(_ sender: Any) {
        LoginAPIClient().login()
    }
}

