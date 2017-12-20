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

    
    
    func testNextLevel() {
        
        let score = 6
        let gameScene = GameScene(size: CGSize(width: 2304, height: 1440))
        
        XCTAssertFalse(gameScene.nextLevel(gameScore: score))
    }
    
    func testWalls(){
        
        let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
            
        XCTAssertFalse(gameScene.walls().isEmpty)
    }
    
    func testPlayerPosition(){
        
        let gameScene=GameScene( size: CGSize(width: 2304, height: 1440))
        let pos=CGPoint(x: 2304/2, y: 1440/4)
        
        gameScene.player()
        
        XCTAssertTrue(gameScene.playerShip.position == pos)
    }
    
    func testLoseLife(){
        
        let gameScene=GameScene(size: CGSize(width: 2304, height: 1440))
        
        let life = 2
        let death = 0
        let erro = -1
        
        gameScene.loseLife()
        
        XCTAssertTrue(gameScene.livesNumber == life, "Funciona")
        XCTAssertTrue(gameScene.livesNumber == death, "É suposto acabar o jogo")
        XCTAssertFalse(gameScene.livesNumber == erro, "ERRO!")
    }
    
    func testChaseShipMissile(){
        
        let gameScene = GameScene(size: CGSize(width:2304, height: 1440))
        
        let dist1 = Float(700)
        let dist2 = Float(800)
        
        gameScene.spawnChaseShip()
        gameScene.player()
        gameScene.chaseShipMissile()
    
            
            XCTAssertTrue(gameScene.dist <= dist1)
            
            XCTAssertFalse(gameScene.dist >= dist2)
    }
}
