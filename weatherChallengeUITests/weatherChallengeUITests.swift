//
//  weatherChallengeUITests.swift
//  weatherChallengeUITests
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import XCTest
class weatherChallengeUITests: XCTestCase {

    func testValidZipCode() throws {
        
        let app = XCUIApplication()
        app.launch()
        let validZip = "90013"
        let invalidZip = "Potato"

        let addButton = app.navigationBars["weatherChallenge.WeatherListTableView"].buttons["Add"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()

        let zipCodeTextField = app.textFields["Zip Code"]
        XCTAssertTrue(zipCodeTextField.exists)
        zipCodeTextField.tap()
        zipCodeTextField.typeText(invalidZip)

        let addToListButton = app/*@START_MENU_TOKEN@*/.staticTexts["Add To List"]/*[[".buttons[\"Add To List\"].staticTexts[\"Add To List\"]",".staticTexts[\"Add To List\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(addToListButton.exists)
        addToListButton.tap()

        let alert = app.alerts["Woops"]
        XCTAssertTrue(alert.exists)

        let alertAction = alert.scrollViews.otherElements.buttons["Ok"]
        XCTAssertTrue(alertAction.exists)
        alertAction.tap()

        let backButton = app.navigationBars["weatherChallenge.AddWeatherView"].buttons["Back"]
        backButton.tap()

        addButton.tap()
        zipCodeTextField.tap()
        zipCodeTextField.typeText(validZip)
        addToListButton.tap()

        let cell = app.tables.cells
        XCTAssertTrue(cell.element(boundBy: 3).exists)
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Los Angeles"]/*[[".cells[\"Los Angeles, 92°\"].staticTexts[\"Los Angeles\"]",".staticTexts[\"Los Angeles\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        cell.element(boundBy: 3).tap()
    }
    
    func testValidCell() throws {
        let app = XCUIApplication()
        app.launch()
        let sanFranCell = app.tables.staticTexts["San Francisco"]
        XCTAssertTrue(sanFranCell.exists)
        XCTAssertTrue(app.tables.staticTexts["Salt Lake City"].exists)
        XCTAssertTrue(app.tables.staticTexts["New York"].exists)
        sanFranCell.tap()
    }
}
