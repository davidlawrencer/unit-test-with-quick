//
//  unit_tests_with_quickTests.swift
//  unit-tests-with-quickTests
//
//  Created by David Rifkin on 2/11/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import unit_tests_with_quick

class UnitTestsWithQuickTests: XCTestCase {
  
  var eventJSONData = Data()
  
  override func setUp() {
    guard let jsonPath = Bundle.main.path(forResource: "event", ofType: "json") else {
      XCTFail("Could not find event JSON file")
      return
    }
    
    let jsonURL = URL(fileURLWithPath: jsonPath)
    
    do {
      eventJSONData = try Data(contentsOf: jsonURL)
    } catch {
      XCTFail("\(error)")
    }
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testDecodeEvents() {
    var events = [Event]()
    
    do {
      let eventInfo = try TicketmasterResponse.decodeEventsFromData(from: eventJSONData)
      events = eventInfo
    } catch {
      XCTFail("\(error)")
    }
    
    // Assert
    XCTAssertTrue(events.count == 20, "Was expecting 20 events, but found \(events.count)")
  }
  
  func testGetUrlFromEventInstance() {
    var events = [Event]()
    
    do {
      let eventInfo = try TicketmasterResponse.decodeEventsFromData(from: eventJSONData)
      events = eventInfo
    } catch {
      XCTFail("\(error)")
    }
    
    guard events.count > 0 else {
      XCTFail("No events were found")
      return
    }

    let firstEvent = events[0]
  
    XCTAssertNotNil(URL(string: firstEvent.url))
  }
  
  // MARK: - MuseumItem Model
  func testDecodeMuseumItems() {
    guard let jsonPath = Bundle.main.path(forResource: "museum", ofType: "json") else {
      XCTFail("Could not find museumItem JSON file")
      return
    }
    
    let jsonURL = URL(fileURLWithPath: jsonPath)
    var museumItemJSONData = Data()
    
    do {
      museumItemJSONData = try Data(contentsOf: jsonURL)
    } catch {
      XCTFail("\(error)")
    }
    
    // Act
    var museumItems = [MuseumItem]()
    
    do {
      let museumItemInfo = try RijksmuseumResponse.decodeMuseumItemsFromData(from: museumItemJSONData)
      museumItems = museumItemInfo
    } catch {
      XCTFail("\(error)")
    }
    
    // Assert
    XCTAssertTrue(museumItems.count == 20, "Was expecting 20 museum items, but found \(museumItems.count)")
  }
}

class TestSpec: QuickSpec {
  override func spec() {
    describe("an event") {
      
      var eventJSONData = Data()
      beforeEach {
        guard let jsonPath = Bundle.main.path(forResource: "event", ofType: "json") else {
          XCTFail("Could not find event JSON file")
          return
        }

        let jsonURL = URL(fileURLWithPath: jsonPath)
        
        do {
          eventJSONData = try Data(contentsOf: jsonURL)
        } catch {
          XCTFail("\(error)")
        }
      }
      context("when we decode it from JSON") {
        it("should return an array of objects") {
          var events = [Event]()
          do {
            let eventInfo = try TicketmasterResponse.decodeEventsFromData(from: eventJSONData)
            events = eventInfo
          } catch {
            XCTFail("\(error)")
          }
          expect(events.count).to(equal(20))
        }
      }
    }
  }
}
