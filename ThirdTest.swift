func testWalls(){
      
        
      let gameScene=GameScene()
      let leftWall=[[Float(30),Float(27)]]
      let rightWall=[[Float(2274),Float[27]]



      XCTAssertTrue(gameScene.walls(points:leftWall))
      XCTAssertTrue(gameScene.walls(points:rightWall))



}
