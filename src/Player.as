package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity
	import net.flashpunk.FP
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Grant Wu
	 */

	public class Player extends Entity
	{
		public var xVelocity:Number;
		private var yVelocity:Number;
		private var mass:Number;
		private var maxSpeed:Number;
		private var isJumping:Boolean;
		private var facing:Number;
		private var gun:Gun;
		private var image:Image;
		private var currentGun:String;
		private var mineCooldown:Number;
		private var mineTimer:Number;
		private var particles:Emitter;
		private var isDead:Boolean;
		private var deathCounter:Number;
		private var tintCounter:Number;
		private var activeMap:Spritemap;
		private var pistolMap:Spritemap;
		private var shotgunMap:Spritemap;
		private var machineGunMap:Spritemap;
		private var flameThrowerMap:Spritemap;

		public function Player() 
		{
			tintCounter = 0;
			deathCounter = 0;
			isDead = false;
			particles = new Emitter(new BitmapData(4, 4, true, 0xFFFF0000), 4, 4);
			particles.newType("blood", [0]);
			particles.relative = false;
			particles.setAlpha("blood");
			particles.setMotion("blood", 0 , 70, 0.7, 360, 50, 0.7, Ease.quadOut);
			
			pistolMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
			pistolMap.add("idle", [0], 10);
			pistolMap.add("upIdle", [6], 10);
			pistolMap.add("upRunning", [18, 19, 20, 21, 22, 23], 10);
			pistolMap.add("running", [24, 25, 26, 27, 28, 29], 10);
			
			machineGunMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
			machineGunMap.add("idle", [2], 10);
			machineGunMap.add("upIdle", [8], 10);
			machineGunMap.add("running", [48, 49, 50, 51, 52, 53], 10);
			machineGunMap.add("upRunning", [54, 55, 56, 57, 58, 59], 10);
			
			shotgunMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
			shotgunMap.add("idle", [1], 10);
			shotgunMap.add("upIdle", [7], 10);
			shotgunMap.add("running", [36, 37, 38, 39, 40, 41], 10);
			shotgunMap.add("upRunning", [42, 43, 44, 45, 46, 47], 10);
			
			flameThrowerMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
			flameThrowerMap.add("idle", [3], 10);
			flameThrowerMap.add("upIdle", [9], 10);
			flameThrowerMap.add("running", [60, 61, 62, 63, 64, 65], 10);
			flameThrowerMap.add("upRunning", [66, 67, 68, 69, 70, 21], 10);
			
			activeMap = pistolMap;
			
			x = FP.screen.width / 2;
			y = FP.screen.height - 300;
			width = 110;
			height = 133;
			xVelocity = 0.0;
			yVelocity = 0.0;
			maxSpeed = 700;
			mass = 5.0;
			setHitbox(40, height + 3, -5);
			type = "player";
			graphic = new Graphiclist(activeMap, particles);
			facing = 1;
			gun = new Pistol();
			mineTimer = 0;
			mineCooldown = 1.5;
			activeMap.tinting = 0.5;
			activeMap.color = 0xFF0000;
		}
		
		override public function update():void
		{
			if (!isDead)
			{
				getKeys();
				updatePosition();
				receiveForce(0, 300);
				gun.update();
				detectCollisions();
				updateSprite();
				if (mineTimer > 0)
				{
					mineTimer -= FP.elapsed;
				}
				getItem();
				isOnMap();
				if (GameProperties.HP <= 0) {
					destroy();
				}
				
				if (tintCounter > 0)
				{
					tintCounter -= FP.elapsed;
				}
				else 
				{
					activeMap.tinting = 0
				}
			}
			else
			{
				deathCounter += FP.elapsed;
				if (deathCounter > 2)
				{
					FP.world.remove(this);
					GameProperties.revertGameState();
				}
			}
		}
		
		private function updateSprite():void
		{
			if (Input.check(Key.UP))
			{
				if (xVelocity != 0) 
				{
					activeMap.play("upRunning");
				}
				else if (xVelocity == 0)
				{
					activeMap.play("upIdle");
				}
			}
			else
			{
				if (xVelocity != 0) 
				{
					activeMap.play("running");
				}
				else if (xVelocity == 0)
				{
					activeMap.play("idle");
				}
			}
			
			if (facing == -1) 
			{
				activeMap.flipped = true;
			} 
			else
			{
				activeMap.flipped = false;
			}
		}
		
		private function updatePosition():void
		{
			x += xVelocity * FP.elapsed;
			y += yVelocity * FP.elapsed;
		}
		
		private function detectCollisions():void
		{
			if (collide("bomb", x, y)) 
			{
				trace("BOOM!");
			}
			
			var collidedEntities:Vector.<Entity> = new Vector.<Entity>;
			collideInto("platform", x, y, collidedEntities);
			if (collidedEntities.length == 0)
			{
				isJumping = true;
			}
			
			for each (var entity:Entity in collidedEntities)
			{
				handlePlatformCollision(entity);
			}
		}

		private function handlePlatformCollision(entity:Entity):void
		{
			if ((y + height) - (yVelocity * FP.elapsed) < entity.y + 4)
			{
				if (isJumping == true && yVelocity >= 0)
				{
					yVelocity = 0;
					y = entity.y - height + 1;
					isJumping = false;
				}
				else if (isJumping == false)
				{
					yVelocity = 0;
				}
			}
		}
		
		public function receiveForce(xForce:Number, yForce:Number):void
		{
			xVelocity += xForce / mass;
			if (xVelocity > maxSpeed) 
			{
				xVelocity = maxSpeed;
			} 
			else if (xVelocity < -maxSpeed)
			{
				xVelocity = -maxSpeed;
			}
			
			yVelocity += yForce / mass;
		}
		
		private function slowDown():void
		{
			if (xVelocity > 0) 
			{
				xVelocity -= 500;
				if (xVelocity < 0) 
				{
					xVelocity = 0;
				}
			}
			if (xVelocity < 0)
			{
				xVelocity += 500;
				if (xVelocity > 0)
				{
					xVelocity = 0;
				}
			}
		}
		
		private function getKeys():void 
		{
			var force:Number = 500.0;
			var jumpForce:Number = -7500.0;
			
			if (Input.check(Key.LEFT) && Input.check(Key.RIGHT))
			{
				slowDown();
			}
			else if (Input.check(Key.LEFT)) 
			{
				receiveForce(-force, 0);
				facing = -1
			}
			else if (Input.check(Key.RIGHT))
			{
				receiveForce(force, 0);
				facing = 1
			}
			else if (!Input.check(Key.RIGHT) && !Input.check(Key.LEFT))
			{
				slowDown();
			}
			
			if (Input.pressed(Key.SPACE) && isJumping == false)
			{
				isJumping = true;
				yVelocity = -1050;
			}
			
			if (Input.check(Key.Z))
			{	
				var yShot:int = 0
				if (Input.check(Key.UP))
				{
					yShot = 1
					if (facing == 1)
					{
						gun.Fire(x + 92, y + 13, facing, yShot);
					}
					else
					{
						gun.Fire(x + 2, y + 13, facing, yShot);
					}
					
					return;
				}
				
				if (facing == 1)
				{
					gun.Fire(x + 94, y + 22, facing, yShot);
				}
				else
				{
					gun.Fire(x + 1, y + 22, facing, yShot);
				}
			}
			
			if (Input.pressed(Key.DOWN))
			{
				if (mineTimer <= 0 && GameProperties.traps > 0)
				{
					FP.world.add(new BearTrap(x + width / 2, y + height - 35));
					mineTimer = mineCooldown;
					GameProperties.traps--;
				}
			}
			
			if (Input.pressed(Key.E))
			{
				if (collide("shopTrigger", x, y))
				{
					GameProperties.newGameState(new ShopMenu(this));
				}
			}
		}
		
		public function getItem():void
		{
			var scrap:Item = collide("item", x, y) as Item;
			if (scrap)
			{
				GameProperties.Metal += scrap.getValue();
				scrap.destroy();
			}
		}
		
		public function isOnMap():Boolean
		{
			//if (x < -800 || x > 1600 || 
			if (y > 800	) {
				destroy();
				return false;
			} else {
				return true;
			}
		}
		
		public function switchWeapon(gun_:Gun, gunId:int):void
		{
			switch(gunId)
			{
				case 0:
					activeMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
					activeMap.add("idle", [0], 10);
					activeMap.add("upIdle", [6], 10);
					activeMap.add("upRunning", [18, 19, 20, 21, 22, 23], 10);
					activeMap.add("running", [24, 25, 26, 27, 28, 29], 10);
					graphic = new Graphiclist(activeMap, particles);
					break;
				case 1:
					activeMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
					activeMap.add("idle", [2], 10);
					activeMap.add("upIdle", [8], 10);
					activeMap.add("running", [48, 49, 50, 51, 52, 53], 10);
					activeMap.add("upRunning", [54, 55, 56, 57, 58, 59], 10);
					graphic = new Graphiclist(activeMap, particles);
					break;
				case 2:
					activeMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
					activeMap.add("idle", [1], 10);
					activeMap.add("upIdle", [7], 10);
					activeMap.add("running", [36, 37, 38, 39, 40, 41], 10);
					activeMap.add("upRunning", [42, 43, 44, 45, 46, 47], 10);
					graphic = new Graphiclist(activeMap, particles);
					break;
				case 3:
					activeMap = new Spritemap(Assets.HEROSPRITE, 110, 133);
					activeMap.add("idle", [3], 10);
					activeMap.add("upIdle", [9], 10);
					activeMap.add("running", [60, 61, 62, 63, 64, 65], 10);
					activeMap.add("upRunning", [66, 67, 68, 69, 70, 21], 10);
					graphic = new Graphiclist(activeMap, particles);
					break;
			}
			gun = gun_;
		}
		
		public function destroy():void
		{
			isDead = true;
			collidable = false;
			activeMap.visible = false;
			for (var i:int = 0; i < 100; ++i)
			{
				particles.emit("blood", x + Math.random() * width, y + Math.random() * height);
			}
		}
		
		public function tintRed():void
		{
			tintCounter = 0.5;
			activeMap.color = 0xFF0000;
			activeMap.tinting = 0.4;
		}
	}

}