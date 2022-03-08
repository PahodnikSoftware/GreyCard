//
//  DataBaseViewController.swift
//  GreyCard
//
//  Created by Leo on 04.03.2022.
//

import UIKit

class DataBaseViewController: UIViewController {
    @IBOutlet weak var dataBaseTable: UITableView!
    
    let dataBaseVM = DataBaseViewModel()
    
    @IBAction func addPlayerToDataBase(_ sender: Any) {

        Game.shared.playersDataBase.append("")
        let row = [IndexPath.init(row: dataBaseVM.numberOfPlayersInDataBase - 1, section: 0)]
        
        self.dataBaseTable.beginUpdates()
        self.dataBaseTable.insertRows(at: row, with: .automatic)
        self.dataBaseTable.endUpdates()
        alert(title: "Введите имя", message: "", style: .alert, row: row)
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style, row: [IndexPath]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            let textFieldInputText = alertController.textFields?.first?.text
            self.dataBaseVM.addPlayerToDataBase(playersName: textFieldInputText!)
            self.dataBaseTable.reloadData()
        }
        //adding text field
        alertController.addTextField {  textField in
            textField.autocapitalizationType = .words
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)  //present the alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBaseTable.delegate = self.dataBaseVM
        dataBaseTable.dataSource = self
        
        //for drag and drop
        dataBaseTable.dragDelegate = self.dataBaseVM
        dataBaseTable.dropDelegate = self.dataBaseVM
        dataBaseTable.dragInteractionEnabled = true
    }
}

extension DataBaseViewController: UITableViewDataSource {
    //MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataBaseVM.numberOfPlayersInDataBase
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataBaseTableCell", for: indexPath) as! DataBaseTableViewCell
        let player = dataBaseVM.playersDataBase[indexPath.row]
        cell.nameLabel.text = player
        if dataBaseVM.playersOnEvent.contains(player) {
            cell.checkBoxButton.isSelected = true
        }
        return cell
    }
    
    //for drag-to-delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let player = Game.shared.playersDataBase[indexPath.row]
            if dataBaseVM.playersOnEvent.contains(player) {
                dataBaseVM.removeFromPlayersOnEvent(player: player)
            }
            dataBaseVM.removeFromplayersDataBase(index: indexPath.row)
            self.dataBaseTable.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    //for drag and drop
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model via ViewModel
        dataBaseVM.moveCells(sourceIndexPath: sourceIndexPath.row, destinationIndexPath: destinationIndexPath.row)
    }
}
