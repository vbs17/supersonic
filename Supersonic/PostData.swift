
import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    //Firebaseはデータの追加や更新があるとデータがFIRDataSnapshotクラスとして渡してきます
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    //@IBAction func handlePostButton(sender: AnyObject) 
    //PostViewcontroller.swiftのこのメソッドやね
    //Postviewcontroller → Firebase → FIRDataSnapshot → PostData
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDictionary["name"] as? String
        
        caption = valueDictionary["caption"] as? String
        
        //投稿時にlikesというキーは設定していないことに気づくかと思います どこで設定したの？
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDictionary["time"] as! NSTimeInterval)
    }
}