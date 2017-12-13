func testWalls(){
      
        
      let gameScene=GameScene()
      let leftWall=[[Float(30),Float(27)]]
      let rightWall=[[Float(2274),Float[27
      
      //Esquerda
        for i in stride(from: -6, to: 1479, by: 33) { leftWall.append([Float(30), Float(i)]) }
        
        //Direita
        for i in stride(from: -6, to: 1479, by: 33) {rightWall.append([Float(2274), Float(i)]) }                                  



      XCTAssertTrue(gameScene.walls(points:leftWall))
      XCTAssertTrue(gameScene.walls(points:rightWall))

  
                     
      
}
