

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleLoginButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            if address.characters.isEmpty || password.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
            
              SVProgressHUD.show()
//表示名をfirebaseに保存するためにはFIRUserProfileChangeRequest内のdisplayNameのプロパティにdisplayNameを代入する作業したから
            //今度はFIRUserのdisplayNameにそれを代入できてここで使ってる
            FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                if error != nil {
                     SVProgressHUD.showErrorWithStatus("エラー")
                    print(error)
                } else {
                    if let displayName = user?.displayName {
                        self.setDisplayName(displayName)
                    }
                    SVProgressHUD.dismiss()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func handleCreateAcountButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text,
            let displayName = displayNameTextField.text {
                if address.characters.isEmpty || password.characters.isEmpty
                || displayName.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
             SVProgressHUD.show()
                                                    //ここのFIRUserのdisplayNameはnilでもok
            FIRAuth.auth()?.createUserWithEmail(address, password: password) { user, error in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("エラー")
                    print(error)
                } else {//VCのcurrentUserは、現在ログインしているユーザー情報(FIRUserのインスタンス)が入っています
                    //2個目(signInWithEmail)を実行したら入る
                    FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                        if error != nil {
                            SVProgressHUD.showErrorWithStatus("エラー")
                            print(error)
                        } else {
                            if let user = user {
      //表示名をfirebaseに保存するためにはFIRUserProfileChangeRequest内のdisplayNameのプロパティにdisplayNameを代入する必要がある
                                let request = user.profileChangeRequest()
                                request.displayName = displayName
                                request.commitChangesWithCompletion() { error in
                                    if error != nil {
                                        print(error)
                                    } else {
                                        self.setDisplayName(displayName)
                                        SVProgressHUD.dismiss()
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDisplayName(name: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
    }

}
