

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                        //currentUserは、現在ログインしているユーザー情報(FIRUserのインスタンス)が入っています
                        //2個目(signInWithEmail)を実行したら入る
        if FIRAuth.auth()?.currentUser == nil {
            dispatch_async(dispatch_get_main_queue()) {
                let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(loginViewController!, animated: true, completion: nil)
            }
            
        }
    }
    
    func setupTab() {
        
        let tabBarController = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        
        addChildViewController(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMoveToParentViewController(self)
       
        let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("Home")
        let settingViewController = storyboard?.instantiateViewControllerWithIdentifier("Setting")
        
        tabBarController.setViewController(homeViewController, atIndex: 0)
        tabBarController.setViewController(settingViewController, atIndex: 2)
        
       
        tabBarController.highlightButtonAtIndex(1)
        tabBarController.setAction({
                        let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageSelect")
            self.presentViewController(imageViewController!, animated: true, completion: nil)
            }, atIndex: 1)
    }


}

