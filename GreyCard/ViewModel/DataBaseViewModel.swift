//
//  DataBaseViewModel.swift
//  GreyCard
//
//  Created by Leo on 07.03.2022.
//

import Foundation
import UIKit

class DataBaseViewModel: NSObject, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    
    var numberOfPlayersInDataBase: Int {
        return Game.shared.playersDataBase.count
    }
    
    var playersDataBase: [String] {
        return Game.shared.playersDataBase
    }
    
    var playersOnEvent: [String] {
        return Game.shared.playersOnEvent
    }
    
    func addPlayerToDataBase(playersName: String) {
        Game.shared.playersDataBase[Game.shared.playersDataBase.count - 1] = playersName
        UserDefaults.standard.set(Game.shared.playersDataBase, forKey: "playersDataBase")
    }
    
    func removeFromPlayersOnEvent(player: String) {
        Game.shared.playersOnEvent.remove(at: Game.shared.playersOnEvent.firstIndex(of: player)!)
    }
    
    func removeFromplayersDataBase(index: Int) {
        Game.shared.playersDataBase.remove(at: index)
        UserDefaults.standard.set(Game.shared.playersDataBase, forKey: "playersDataBase")
    }
    
    func moveCells(sourceIndexPath: Int, destinationIndexPath: Int) {
        let mover = Game.shared.playersDataBase.remove(at: sourceIndexPath)
        Game.shared.playersDataBase.insert(mover, at: destinationIndexPath)
    }
    
    //MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  //deselecting rows straight after selecting
    }
    
    //MARK: - UITableViewDragDelegate methods
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = Game.shared.playersDataBase[indexPath.row]
            return [ dragItem ]
    }
    
    //MARK: - UITableViewDropDelegate methods
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        //
    }
}
