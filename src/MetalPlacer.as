package  
{
	/**
	 * ...
	 * @author Grant Wu
	 */
	
	import net.flashpunk.FP;

	public class MetalPlacer
	{
		private static var metalSpawns:Number;
		private static var timeUntilNextSpawn:Number;
		private static var wave:int;
		
		public function MetalPlacer()
		{

		}
		
		public static function init():void
		{
			metalSpawns = 0;
			timeUntilNextSpawn = 10;
			wave = 0;
		}
		
		public static function update():void
		{
			if (metalSpawns <= 0)
			{
				makeMetal();
				metalSpawns = timeUntilNextSpawn;
			}
			else
			{
				metalSpawns -= FP.elapsed;
			}
		}
		private static function makeMetal():void
		{
			wave++;
			for (var i:int = 0; i < Math.random() * 10; ++i)
			{
				makeMetalSegment();
			}
		}
		private static function makeMetalSegment():void
		{
			var location:int = Math.round(Math.random() * 4);
			switch(location)
			{
				case 0:
					FP.world.add(new Item(Math.random() * 1600, -Math.random() * 600, 10));
					break;
				case 1:
					FP.world.add(new Item(Math.random() * 1600, -Math.random() * 600, 10));
					break;
				case 2:
					FP.world.add(new Item(Math.random() * 1600, -Math.random() * 600, 10));
					break;
				case 3:
					FP.world.add(new Item(Math.random() * 1600, -Math.random() * 600, 10));
					break;
				default:
					break;
			}
		}
		
	}

}