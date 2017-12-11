func testPlayerMovement(){
  
        let gameScene=GameScene(size: CGSize(width: 2304, height:1440))
        let posicao = GameScene(playerPosition: CGPoint(x:2304/2-33 y:1440/2))
 
        //A
        
        XCTAssertEqual(gameScene.keyDown.event.keyCode==0, CGPoint(x:(2304/2)-33,y:1440/2)" Está correto")

      //D
       

        XCTAssertEqual(gameScene.keyDown.event.keyCode==2, CGPoint(x:2304/2+33,y:1440/2)" Está correto")

     //W
      

        XCTAssertEqual(gameScene.keyDown.event.keyCode==13, CGPoint(x:(2304/2),y:1440/2-33)" Está correto")
    
    //S
        

        XCTAssertEqual(gameScene.keyDown.event.KeyCode==1, CGPoint(x:(2304/2),y:1440/2+33)" Está correto")

}
