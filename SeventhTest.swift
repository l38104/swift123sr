func testChaseShipMissile(){

  let gameScene= GameScene(size: CGSize(width:2304, height: 1440))
  
  let dist= 700
  let dist2=800
  gameScene.ShapeShipMissile()

  
  if gameScene.distance<= dist{
    
       XCTAssertTrue(missile.position=gameScene.chaseShip.position,"atira")
   }
   else{
    
      XCTAssertFalse(missile.position!=gameScene.chaseShip.position,"não atira")    
        }   
   
