func testPlayerMovement(){
  
        let gameScene=GameScene(size: CGSize(width: 2304, height:1440))
        var posicao = GameScene(playerPosition: CGPoint(x:2304/2-33 y:1440/2))
 
        //A
        
        XCTAssertEqual(gameScene.keyDown.posicao, CGPoint(x:(2304/2)-33,y:1440/2)" Está correto")

      //D
       var posicao = GameScene(playerPosition: CGPoint(x:2304/2+33 y:1440/2))

        XCTAssertEqual(gameScene.keyDown.posicao, CGPoint(x:2304/2+33,y:1440/2)" Está correto")

     //W
       var posicao = GameScene(playerPosition: CGPoint(x:2304/2 y:1440/2-33))

        XCTAssertEqual(gameScene.keyDown.posicao, CGPoint(x:(2304/2),y:1440/2-33)" Está correto")
    
    //S
         var posicao = GameScene(playerPosition: CGPoint(x:2304/2 y:1440/2+33))

        XCTAssertEqual(gameScene.keyDown.posicao, CGPoint(x:(2304/2),y:1440/2+33)" Está correto")

}
