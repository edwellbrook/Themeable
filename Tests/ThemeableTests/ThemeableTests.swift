import XCTest
import UIKit.UIView
import UIKit.UIColor
@testable import Themeable

let whiteTheme = UITheme(backgroundColor: .white)
let blackTheme = UITheme(backgroundColor: .black)

let manager = ThemeManager<UITheme>(default: whiteTheme)

struct UITheme {
    let backgroundColor: UIColor
}

final class ThemedView: UIView, Themeable {

    typealias ThemeType = UITheme

    let themer = Themer<ThemedView>(manager: manager)


    override init(frame: CGRect) {
        super.init(frame: frame)

        self.themer.theme(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyTheme(theme: UITheme) {
        self.backgroundColor = theme.backgroundColor
    }

}

class ThemeableTests: XCTestCase {
    func testExample() {
        let view1 = ThemedView()

        // view has been created with correct theme
        XCTAssertEqual(view1.backgroundColor, UIColor.white)

        // change theme
        manager.theme = blackTheme

        // verify view has changed with theme
        XCTAssertEqual(view1.backgroundColor, UIColor.black)

        let view2 = ThemedView()

        // verify new view has been created with latest theme
        XCTAssertEqual(view2.backgroundColor, UIColor.black)
    }


    static var allTests : [(String, (ThemeManagerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
