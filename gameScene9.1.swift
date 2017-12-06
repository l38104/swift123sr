import XCTest
@ testable import Space_Race

class GameSceneTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testnextLevel() {
        
        let score = 6
        
        let scene = GameScene(size: CGSize(width: 2304 , height: 1440))
        
        let gameScene = GameScene(size: scene.size)
        
        XCTAssertFalse(gameScene.nextLevel(gameScore: score))
        
    }
}
