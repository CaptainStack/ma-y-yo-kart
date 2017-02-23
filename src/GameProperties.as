package  
{
	import flash.display.InteractiveObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;

	/**
	 * ...
	 * @author Grant Wu
	 */
	public class GameProperties
	{
		public static var Ammo:int;
		public static var Metal:int;
		public static var HP:int;
		public static var GameStates:Vector.<World>
		public static var MainPlayer:Player;
		public static var MomHP:int;
		public static var CarState:int;
		public static var traps:int;
		
		public static function init(MainPlayer_:Player):void
		{
			traps = 5;
			MainPlayer = MainPlayer_;
			Ammo = 300;
			Metal = 0;
			HP = 100;
			GameStates = new Vector.<World>;
			MomHP = 200;
			CarState = 0;
		}
		
		public static function newGameState(world:World):void
		{
			GameStates.push(FP.world);
			FP.world = world;
		}
		
		public static function revertGameState():void
		{
			FP.world = GameStates.pop();
		}
	}
}