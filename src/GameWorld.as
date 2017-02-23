package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	 
	public class GameWorld extends World
	{
		private var mainPlayer:Player;
		private var waveCounter:Number;
		private var bgMusic:Sfx;
		private var shed:Entity;
		private var shedImage:Image;
		private var mom:Mom;
		private var kartSprite:Spritemap
		private var kart:Entity;
		
		public function GameWorld() 
		{
			kartSprite = new Spritemap(Assets.KARTSPRITES, 330, 200);
			kartSprite.add("one", [0], 1);
			kartSprite.add("two", [1], 1);
			kartSprite.add("three", [2], 1);
			kart = new Entity(150, 333);
			kart.graphic = kartSprite;
			kartSprite.play("one");
			
			mainPlayer = new Player();
			mom = new Mom;
			GameProperties.init(mainPlayer);
			shedImage = new Image(Assets.SHEDIMAGE);
			shed = new Shed(mom);
			add(shed);
			add(kart);
			add(new ShopTrigger(475, 400));		
			waveCounter = 30;
			add(mainPlayer);
			add(new Platform(3200, 70, -1200, FP.screen.height - 70));
			add(new Platform(950, 70, -1200, -60));
			add(new Platform(950, 70, 0, -60));
			add(new SmallPlatform(-600, 450));
			add(new SmallPlatform(-800, 260));
			add(new SmallPlatform( -400, 325));
			add(new SmallPlatform(900, 250));
			add(new SmallPlatform(-700, 100));
			add(new SmallPlatform(1200, 450));
			add(new SmallPlatform(1400, 325));
			add(new SmallPlatform(1100, 100));
			add(new SmallPlatform(200, -180));
			add(new SmallPlatform(450, -180));
			add(new SmallPlatform(300, -380));
			add(new Gui);
			//add(new Item(500, 500, 10));
			MetalPlacer.init();
			add(new Mom);
			add(mom);
			EnemySpawner.init();
			bgMusic = new Sfx(Assets.BGBUILD);
			bgMusic.play();
		}
	
		override public function update():void
		{
			moveCamera();
			EnemySpawner.update();
			MetalPlacer.update();
			if (GameProperties.CarState >= 500)
			{
				bgMusic.stop();
				GameProperties.newGameState(new(VictoryScreen));
			}
			else if (GameProperties.CarState > 333)
			{
				kartSprite.play("three");
			}
			else if (GameProperties.CarState > 166)
			{
				kartSprite.play("two");
			}
			
			if (isGameOver())
			{
				
			}
			super.update();
		}
		
		private function isGameOver():Boolean
		{
			return GameProperties.HP > 0;
		}
		
		private function spawnEnemies():void
		{
			if (waveCounter > 0)
			{
				waveCounter -= FP.elapsed;
			}	
		}
		
		private function moveCamera():void
		{
			var xOffset:Number = 0;
			if (mainPlayer.x - FP.world.camera.x >= 600)
			{
				xOffset = mainPlayer.x - FP.world.camera.x - 600;
			}
			else if (mainPlayer.x - FP.world.camera.x <= 200)
			{
				xOffset = mainPlayer.x - FP.world.camera.x - 200;
			}
			
			var yOffset:Number = 0;
			if (mainPlayer.y - FP.world.camera.y != 400)
			{
				yOffset = mainPlayer.y - FP.world.camera.y - 400;
			}
			
			FP.world.camera.offset(xOffset, yOffset);
		}
	}

}