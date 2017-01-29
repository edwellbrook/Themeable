//
//  ThemeableTests.swift
//  ThemeableTests
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import XCTest
@testable import Themeable

enum TestColor {
    case white, black
}

struct UITheme: Theme {

    let identifier: String
    let backgroundColor: TestColor

    static let white = UITheme(identifier: "co.brushedtype.Themeable.white-theme", backgroundColor: TestColor.white)
    static let black = UITheme(identifier: "co.brushedtype.Themeable.black-theme", backgroundColor: TestColor.black)

    static let variants: [UITheme] = [ .white, .black ]
    static let manager = ThemeManager<UITheme>(default: .white, forceDefault: true)

}

class ThemeableView: Themeable {

    var backgroundColor: TestColor = .white

    init() {
        UITheme.manager.register(themeable: self)
    }

    func apply(theme: UITheme) {
        self.backgroundColor = theme.backgroundColor
    }

}

class ThemeableTests: XCTestCase {

    func testExample() {
        let view1 = ThemeableView()

        // view has been created with correct theme
        XCTAssertEqual(view1.backgroundColor, TestColor.white)

        // change theme
        UITheme.manager.activeTheme = .black

        // verify view has changed with theme
        XCTAssertEqual(view1.backgroundColor, TestColor.black)

        let view2 = ThemeableView()

        // verify new view has been created with latest theme
        XCTAssertEqual(view2.backgroundColor, TestColor.black)

        // verify theme manager uses last used theme
        let NewManager = ThemeManager<UITheme>(default: .white)
        XCTAssertEqual(UITheme.black, NewManager.activeTheme)
    }


    static var allTests : [(String, (ThemeableTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }

}
