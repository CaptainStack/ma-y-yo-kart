package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Andre Stackhouse
	 */
	public class MainMenuWorld extends World
	{
		
		public function MainMenuWorld() 
		{
			var victory:Entity = new Entity();
			victory.graphic = new Image(Assets.TITLE);
			add(victory);
			//Add spash screen and "press enter to play"
		}
		
		override public function update():void
		{
			if (Input.released(Key.ENTER))
			{
				GameProperties.newGameState(new GameWorld);
			}
		}
	}
}