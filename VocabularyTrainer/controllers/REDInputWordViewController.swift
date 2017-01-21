import Foundation
import UIKit

class REDInputWordViewController : UIViewController {
    
    var inputWordView : REDInputWordView {
        get {
            return view as! REDInputWordView
        }
    }

    var inputWordViewModel : REDInputWordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        inputWordView.model = inputWordViewModel
    }


}
