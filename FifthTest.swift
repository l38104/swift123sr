     func testPlayerPosition(){
            
            let gameScene=GameScene( size: CGSize(width: 2304, height: 1440))
            let pos=CGPoint(x:0,y:0)
            
            gameScene.player()
            
            XCTAssertFalse(gameScene.playerShip.position == pos )
            
            
        }




