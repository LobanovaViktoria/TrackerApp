import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        print("Test started")
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrackersVC() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = TabBarController.configure()
        window.rootViewController = vc
        window.makeKeyAndVisible()
     
        let trackersVC = (vc.children.first as? UINavigationController)?.viewControllers.first
        print(String(describing: trackersVC))
        guard let view = trackersVC?.view else { return }
        assertSnapshot(matching: view, as: .image)
    }
}

