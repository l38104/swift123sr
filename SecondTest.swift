func testPlayerMovement(){
  
        let position = GameScene(size: CGSize(width: 2304/2 , height: 1440/2))
 
        //A
       
        XCTAssertEqual(GameScene.keyDown.position, CGPoint(x:(2304/2)-33,y:1440)" Está correto")

      //D
      
        XCTAssertEqual(GameScene.keyDown.position, CGPoint(x:(2304/2)+33,y:1440)" Está correto")

     //W
     
        XCTAssertEqual(GameScene.keyDown.position, CGPoint(x:(2304/2),y:1440/2-33)" Está correto")
    
    //S
        XCTAssertEqual(GameScene.keyDown.position, CGPoint(x:(2304/2),y:1440/2+33)" Está correto")

}
