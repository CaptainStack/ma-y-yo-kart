package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class EnemySpawner 
	{
		private static var spawnCounter:Number;
		private static var timeUntilNextSpawn:Number;
		private static var wave:int;
		private static var spawnSound:Sfx;
		
		public function EnemySpawner() 
		{
		}
		
		public static function init():void
		{
			spawnCounter = 0;
			timeUntilNextSpawn = 20;
			wave = 0;
			spawnSound = new Sfx(Assets.MONSTERWHEEZE);
		}
		
		public static function update():void
		{
			if (spawnCounter <= 0)
			{
				spawnEnemies();
				spawnCounter = timeUntilNextSpawn;
			}
			else
			{
				spawnCounter -= FP.elapsed;
			}
		}
		
		private static function spawnEnemies():void
		{
			wave++;
			spawnSound.play();
			for (var i:int = 0; i < wave * 3; ++i)
			{
				spawnEnemy();
			}
		}
		
		private static function spawnEnemy():void
		{
			var location:int = Math.round(Math.random() * 4);
			switch(location)
			{
				case 0:
					FP.world.add(new Crawler(GameProperties.MainPlayer, -1000 - (Math.random() * 500), FP.screen.height - 300));
					break;
				case 1:
					FP.world.add(new Crawler(GameProperties.MainPlayer, 1800 + (Math.random() * 500), FP.screen.height - 300));
					FP.world.add(new Flier(GameProperties.MainPlayer, -400, 200));
					break;
				case 2:
					FP.world.add(new Crawler(GameProperties.MainPlayer, -900 - (Math.random() * 500), FP.screen.height - 1100));
					FP.world.add(new Flier(GameProperties.MainPlayer, -400, 200));
					break;
				case 3:
					FP.world.add(new Crawler(GameProperties.MainPlayer, -900 - (Math.random() * 500), FP.screen.height - 1100));
					break;
				default:
					break;
			}
		}
	}

}