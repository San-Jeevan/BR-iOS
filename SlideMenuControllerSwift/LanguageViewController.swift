

import UIKit

class LanguageViewController: UIViewController {
    
    override func viewDidLoad() {
        let logo = UIImage(named: "elstupid.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        super.viewDidLoad()
    }
    override open var shouldAutorotate: Bool {
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
}
