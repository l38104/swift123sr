func testWalls(){
      
        
      let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
      
      let leftWall=[[Float(30),Float(27)]]
      let rightWall=[[Float(2274),Float[27]]
                     
      gameScene.walls()
                                        
       XCTAssertTrue(leftWall in gameScene.points)
       XCTAssertTrue(rightWall in gameScene.points)		        
  		  
  
                     
      
}
func testTimer(){
      
      /*
      let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
      
      let wait = SKAction.wait(forDuration: 0.01) - Use of unresolved identifier 'SKAction'
      let sequence = SKAction.sequence([call, SKAction.wait(forDuration: 0.02)]) - Use of unresolved identifier 'SKAction'
      
      XCTAssertTrue(gameScene.timer(wait:wait)) - Argument passed to call that takes no arguments
      XCTAssertTrue(gameScene.timer(sequence:sequence)) - Argument passed to call that takes no arguments
      """
     
      */
       
      let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
      
      let posPixelY=1000
      let posPixelYY=1500
      
      gameScene.timer()
      
      XCTAssertNil(gameScene.playerShip.y == posPixelY,"Nada deve acontecer")
      XCTAsserEqual(gameScene.playerShip.y== posPixelYY, gameScene.livesNumber==0)
      
      
      
      
      
      
      
      
}      
      
 
