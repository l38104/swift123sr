func testWalls(){
      
        
      let gameScene=GameScene()
      
      let leftWall=[[Float(30),Float(27)]]
      let rightWall=[[Float(2274),Float[27]]
                                        
       XCTAssertTrue(gameScene.walls(points:leftWall))
       XCTAssertTrue(gameScene.walls(points:rightWall))		        
  		  
  // VE a primeira parte e depois ve a segunda depois deste comentario e comenta o de cima    excepto o gameScene                             
                                        
                                        
                                        
                                        
      
      //Esquerda
        for i in stride(from: -6, to: 1479, by: 33) { leftWall.append([Float(30), Float(i)]) }
        
        //Direita
        for i in stride(from: -6, to: 1479, by: 33) {rightWall.append([Float(2274), Float(i)]) }                                  



      XCTAssertTrue(gameScene.walls(points:leftWall))
      XCTAssertTrue(gameScene.walls(points:rightWall))

  
                     
      
}
