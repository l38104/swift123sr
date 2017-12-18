func testAddObstacle(){
     

     let gameScene= GameScene(size: CGSize(width: 2304 , height: 1440))    



     let esquerda= [[Float(70),Float(1473)]]
     let direita= [[Float(70),Float(1473)]]
     
     
     gameScene.addObstacle()
     
     XCTAssertTrue(gameScene.points == esquerda )
     XCTAssertTrue(gameScene.points == direita)

     nao funciona: esquerda= [[Float(70),Float(1473)]] nao da o array que se quer testar
