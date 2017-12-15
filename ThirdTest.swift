func testWalls(){
      
        
      let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
      
      let leftWall=[[Float(30),Float(27)]]
      let rightWall=[[Float(2274),Float[27]]
                                        
       XCTAssertTrue(gameScene.walls(points:leftWall))
       XCTAssertTrue(gameScene.walls(points:rightWall))		        
  		  
  // VE a primeira parte e depois ve a segunda depois deste comentario e comenta o de cima    excepto o gameScene                             
                                        
                                        
                                        
                                        
      
      //Esquerda
        for i in stride(from: -6, to: 1479, by: 33) { leftWall.append([Float(30), Float(i)]) } - Cannot use mutating member on immutable value: 'leftWall' is a 'let' constant
        
        //Direita
        for i in stride(from: -6, to: 1479, by: 33) {rightWall.append([Float(2274), Float(i)]) } - Cannot use mutating member on immutable value: 'leftWall' is a 'let' constant                                 



      XCTAssertTrue(gameScene.walls(points:leftWall)) - Argument passed to call that takes no arguments
      XCTAssertTrue(gameScene.walls(points:rightWall)) - Argument passed to call that takes no arguments

  
                     
      
}
func testTimer(){
      
      let gameScene=GameScene(size: CGSize(width: 2304 , height: 1440))
      
      let wait = SKAction.wait(forDuration: 0.01) - Use of unresolved identifier 'SKAction'
      let sequence = SKAction.sequence([call, SKAction.wait(forDuration: 0.02)]) - Use of unresolved identifier 'SKAction'
      
      XCTAssertTrue(gameScene.timer(wait:wait)) - Argument passed to call that takes no arguments
      XCTAssertTrue(gameScene.timer(sequence:sequence)) - Argument passed to call that takes no arguments
      
}      
      
      
      
