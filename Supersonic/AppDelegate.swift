

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()//This method should be called after the app is launched and before using Firebase services
        AdobeUXAuthManager.sharedManager().setAuthenticationParametersWithClientID("497d2060120e47c0a75d0a8593cc8f80", withClientSecret: "71dd0b31-7de3-4009-9564-b4e77d2510d9")

        return true  //Configures a default Firebase app.
    }

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

