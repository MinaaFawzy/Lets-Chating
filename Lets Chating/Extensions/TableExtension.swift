
import Foundation
import UIKit


extension UITableView {
    
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: cell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
        
    }
   
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifire = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifire) as? Cell else {
            print(fatalError().localizedDescription)
        }
        return cell
    }
}
