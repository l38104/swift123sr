func testLoseLife(){

      let gameScene=GameScene()
      
      let life = 2
      let death=0
      let erro=-1
      
      XCTAssertTrue(gameScene.loseLife(lifeNumber:life)
      XCTAssertTrue(gameScene.loseLife(lifeNumber:death)
      XCTAssertFalse(gameScene.loseLife(lifeNumber:erro)
}
