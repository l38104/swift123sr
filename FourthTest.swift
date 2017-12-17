func testLoseLife(){

      let gameScene=GameScene()  - emfalta: size: CGSize(width: 2304, height: 1440)
        
      
      let life = 2
      let death=0
      let erro=-1
      
      gameScene.loseLife()
      
      XCTAssertTrue(gameScene.livesNumber==life)
      XCTAssertTrue(gameScene.livesNumber == death ," É suposto acabar o jogo") 
      XCTAssertFalse(gameScene.livesNumber == erro," ERRO!") 
}
                    
                    
                         
     
      
