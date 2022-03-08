//
//  GreyCardUnitTests.swift
//  GreyCardUnitTests
//
//  Created by Leo on 08.03.2022.
//

import XCTest
@testable import GreyCard

class DataBaseViewModelTests: XCTestCase {

    var sut: DataBaseViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = DataBaseViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPlayerAddedToDataBaseCorrectly() {
        // given
        let playerToAdd = "Nick"

        // when
        //technically the method below doesn't add an item; it rewrites the last one
        if sut.playersDataBase.count > 0 {
            sut.addPlayerToDataBase(playersName: playerToAdd)
            
            // then
            XCTAssertEqual(sut.playersDataBase.last, playerToAdd, "Player add to data base process is wrong")
        }
    }
    
    func testPlayerRemovedFromDataBaseCorrectly() {
        // given
        let playersToRemoveIndex = 0
        let databaseInitialCount = sut.playersDataBase.count

        // when
        if databaseInitialCount > 0 {
            sut.removeFromplayersDataBase(index: playersToRemoveIndex)
            
            // then
            XCTAssertEqual(sut.playersDataBase.count, databaseInitialCount - 1, "Player deletion process is wrong")
        }
    }
    
    func testRemovePlayersOnEventCorrectly() {
        // given
        let playerToRemove = "Nick"
        let playersOnEventInitial = sut.playersOnEvent

        // when
        if playersOnEventInitial.contains(playerToRemove) {
            sut.removeFromPlayersOnEvent(player: playerToRemove)
            
            // then
            XCTAssert(!sut.playersOnEvent.contains(playerToRemove), "Player deletion process is wrong")
        }
    }
    
    func testMoveCellsMethodDontChangeNumberOfElements() {
        // given
        let databaseInitialCount = sut.playersDataBase.count

        // when
        if databaseInitialCount > 1 {
            sut.moveCells(sourceIndexPath: 0, destinationIndexPath: 1)
            
            // then
            XCTAssertEqual(sut.numberOfPlayersInDataBase, databaseInitialCount, "Cell moving process is wrong")
        }
    }
}
