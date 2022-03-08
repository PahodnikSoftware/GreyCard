//
//  MainTableViewCell.swift
//  GreyCard
//
//  Created by Leo on 01.03.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roleButton: UIButton!
    
    //buttons to note number of votes (5 is end of voting straight away, so it's 4 max to note)
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    @IBAction func button1action(_ sender: Any) {
        button1.isSelected.toggle()
    }
    @IBAction func button2action(_ sender: Any) {
        button2.isSelected.toggle()
    }
    @IBAction func button3action(_ sender: Any) {
        button3.isSelected.toggle()
    }
    @IBAction func button4action(_ sender: Any) {
        button4.isSelected.toggle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let white = UIAction(title: "Белый", image: UIImage(named: "circleWhite")) { _ in
            self.backgroundColor = UIColor.white
        }
            
        let grey = UIAction(title: "Серый", image: UIImage(named: "circleGrey")) { _ in
            self.backgroundColor = UIColor.systemGray
        }
        
        let golden = UIAction(title: "Золотой", image: UIImage(named: "circleGolden")) { _ in
            self.backgroundColor = UIColor.systemYellow
        }
        
        let roleMenu = UIMenu(title: "", children: [golden, grey, white])
        roleButton.menu = roleMenu
        roleButton.showsMenuAsPrimaryAction = true
    }
}
