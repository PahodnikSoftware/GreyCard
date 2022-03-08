//
//  DataBaseTableViewCell.swift
//  GreyCard
//
//  Created by Leo on 04.03.2022.
//

import UIKit

class DataBaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton! {
        didSet {
            checkBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
            checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        }
    }
    
    @IBAction func checkBoxButtonAction(_ sender: UIButton) {
        sender.checkboxAnimation { [self] in
            //here you can also track the Checked, UnChecked state with sender.isSelected
            let row = self.indexPath!.row
            if sender.isSelected {
                Game.shared.playersOnEvent.append(Game.shared.playersDataBase[row])
            } else {
                Game.shared.playersOnEvent.remove(at: Game.shared.playersOnEvent.firstIndex(of: Game.shared.playersDataBase[row])!)
            }
            UserDefaults.standard.set(Game.shared.playersOnEvent, forKey: "playersOnEvent")
        }
    }
}

//taken from here - https://stackoverflow.com/questions/40437550/how-can-i-get-indexpath-row-in-cell-swift
//to be able to get IndexPath from inside a cell
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
