//
//  GreyCardMainViewModelTests.swift
//  GreyCardUnitTests
//
//  Created by Leo on 08.03.2022.
//

import XCTest
@testable import GreyCard

class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var dataBaseViewModel: DataBaseViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = MainViewModel()
        dataBaseViewModel = DataBaseViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        dataBaseViewModel = nil
        try super.tearDownWithError()
    }

    func testGameStartedCorrectly() {
        // given
        let playersOnEvent = dataBaseViewModel.playersOnEvent
        
        // when
        sut.startTheGame()
            
        // then
        XCTAssertEqual(sut.playersLeftInGame, playersOnEvent, "Game starting process is wrong")
        XCTAssert(sut.makeCellsClear)
    }
    
    func testSavePlayersOrderIsCorrect() {
        // given
        let playersOnEvent = dataBaseViewModel.playersOnEvent
        
        // when
        sut.savePlayersOrder()
            
        // then
        XCTAssertEqual(sut.playersLeftInGame, playersOnEvent, "Saving players order process is wrong")
    }
    
    func testMoveCellsMethodDontChangeNumberOfElements() {
        // given
        let databaseInitialCount = sut.playersLeftInGame.count

        // when
        if databaseInitialCount > 1 {
            sut.moveCells(sourceIndexPath: 0, destinationIndexPath: 1)
            
            // then
            XCTAssertEqual(sut.numberOfPlayersInGame, databaseInitialCount, "Cell moving process is wrong")
        }
    }
    
    func testDragToDeleteWorksProperly() {
        // given
        let playersToRemoveIndex = 0
        let playersLeftInGameInitial = sut.playersLeftInGame

        // when
        if playersLeftInGameInitial.count > 0 {
            let playerToRemove = sut.playersLeftInGame[playersToRemoveIndex]
            sut.dragToDeleteCell(indexPath: 0)
            
            // then
            XCTAssert(!sut.playersLeftInGame.contains(playerToRemove), "Player deletion process is wrong")
        }
    }
}
