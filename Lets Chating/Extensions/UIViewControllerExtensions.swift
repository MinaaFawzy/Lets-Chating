import UIKit


extension UIViewController {
    func basicAlert(title: String?, message: String?, ButtonTitle: String?){
        let alert = UIAlertController(title: title ?? "", message: message ?? "" , preferredStyle: .alert)
        let alertAction = UIAlertAction(title: ButtonTitle ?? "", style: .cancel)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}
