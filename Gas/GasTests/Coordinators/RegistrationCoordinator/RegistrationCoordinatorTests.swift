//
//  RegistrationCoordinatorTests.swift
//  GasTests
//
//  Created by Strong on 4/7/21.
//

import XCTest
@testable import Gas

class RegistrationCoordinatorTests: XCTestCase {

    var sut: RegistrationCoordinatorManager!
    
    override func setUp() {
        sut = RegistrationCoordinatorManager(navigationController: NavigationControllerMock())
    }
    
    func test_WhenStartCalled_MoveToPersonalAccountCalled() {
        sut.start()
        guard let shownVc = sut.navigationController.viewControllers.last else {
            XCTFail("No view controller is shown")
            return
        }
        XCTAssertTrue(shownVc is AddPersonalAccountViewController)
    }
    
}

class NavigationControllerMock: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllers.append(viewController)
    }
}
