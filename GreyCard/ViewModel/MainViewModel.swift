//
//  MainDataSource.swift
//  GreyCard
//
//  Created by Leo on 07.03.2022.
//

import Foundation
import UIKit

class MainViewModel: NSObject,
        UITableViewDelegate,
        UITableViewDragDelegate,
        UITableViewDropDelegate
     {
    
    var makeCellsClear = false  //flag for clearing cell background on game restart
    
    var numberOfPlayersInGame: Int {
        return Game.shared.playersLeftInGame.count
    }
    
    var playersLeftInGame: [String] {
        return Game.shared.playersLeftInGame
    }
    
    func startTheGame() {
        Game.shared.playersLeftInGame = Game.shared.playersOnEvent
        makeCellsClear = true
    }
    
    func savePlayersOrder() {
        Game.shared.playersOnEvent = Game.shared.playersLeftInGame
    }
    
    func moveCells(sourceIndexPath: Int, destinationIndexPath: Int) {
        let mover = Game.shared.playersLeftInGame.remove(at: sourceIndexPath)
        Game.shared.playersLeftInGame.insert(mover, at: destinationIndexPath)
    }
    
    func dragToDeleteCell(indexPath: Int) {
        Game.shared.playersLeftInGame.remove(at: indexPath)
    }
    
    //MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10.2  //row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  //deselecting rows straight after selecting
    }
         
     //MARK: - UITableViewDragDelegate methods
     func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
         let dragItem = UIDragItem(itemProvider: NSItemProvider())
         dragItem.localObject = Game.shared.playersLeftInGame[indexPath.row]
             return [ dragItem ]
     }
     
     //MARK: - UITableViewDropDelegate methods
     func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
         // Handle Drop Functionality
     }
}
