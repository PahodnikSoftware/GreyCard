//
//  ViewController.swift
//  GreyCard
//
//  Created by Leo on 01.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    
    let mainVM = MainViewModel()
    
    @IBAction func startTheGame(_ sender: Any) {
        
        let alert = UIAlertController(title: "Начать игру?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction!) in
            //add additional code to execute when user clicks on OK
            self.mainVM.startTheGame()
            self.mainTable.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { (action: UIAlertAction!) in
            //add additional code to execute when user clicks on cancel
        }))

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveOrderButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Сохранить порядок?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction!) in
            //add additional code to execute when user clicks on OK
            self.mainVM.savePlayersOrder()
        }))

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { (action: UIAlertAction!) in
            //add additional code to execute when user clicks on cancel
        }))

        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self.mainVM
        mainTable.dataSource = self
        
        //for drag and drop functionality
        mainTable.dragDelegate = self.mainVM
        mainTable.dropDelegate = self.mainVM
        mainTable.dragInteractionEnabled = true
    }
}

//UIAdaptivePresentationControllerDelegate - for actions on dismiss of modal screen
extension MainViewController: UIAdaptivePresentationControllerDelegate {
    //this is done for being able to perform actions on dismiss of Database screen
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDataBase" {
          segue.destination.presentationController?.delegate = self;
        }
        self.mainVM.makeCellsClear = false
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.mainTable.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    //MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.numberOfPlayersInGame
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1  //sections per table
    }
    
    //cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! MainTableViewCell
        let player = mainVM.playersLeftInGame[indexPath.row]
        cell.name.text = player
        if self.mainVM.makeCellsClear {
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    //for drag and drop moving rows
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model via ViewModel
        mainVM.moveCells(sourceIndexPath: sourceIndexPath.row, destinationIndexPath: destinationIndexPath.row)
    }
    
    //for drag-to-delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mainVM.dragToDeleteCell(indexPath: indexPath.row)
            self.mainTable.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
