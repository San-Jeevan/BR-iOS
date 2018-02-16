import UIKit

enum LeftMenu: Int {
    case qr = 0
    case lang
    case go
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
    func barcodeScanned(_ itemId: String)
}

class LeftViewController : UITableViewController, LeftMenuProtocol {
    func barcodeScanned(_ itemId: String) {
        self.delegateGo?.barcodeScanned(itemId)
    }
    
    var menus = ["QR-scanner", "Språk", "Video"]
    var qrViewController: UIViewController!
    var languageViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    weak var delegateGo: GoProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.tableHeaderView = UIView(frame: .zero)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let qrViewController = storyboard.instantiateViewController(withIdentifier: "QrViewController") as! QrViewController
         qrViewController.delegatemenu = self
        self.qrViewController = UINavigationController(rootViewController: qrViewController)
        
        let languageViewController = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        self.languageViewController = UINavigationController(rootViewController: languageViewController)
        
        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
        self.delegateGo = goViewController;
        self.goViewController = UINavigationController(rootViewController: goViewController)
        
               
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        //self.imageHeaderView = ImageHeaderView.loadNib()
        //self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .qr:
            self.slideMenuController()?.changeMainViewController(self.qrViewController, close: true)
        case .lang:
            self.slideMenuController()?.changeMainViewController(self.languageViewController, close: true)
        case .go:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 4) {
            
            return UIScreen.main.bounds.size.height - 360.0
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}


    

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if let menu = LeftMenu(rawValue: indexPath.row) {
//            switch menu {
//            case .qr, .lang, .go:
//                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
//                cell.setData(menus[indexPath.row])
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }
    
    

