import UIKit

/// Handles login input and validation
class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.shared.login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

