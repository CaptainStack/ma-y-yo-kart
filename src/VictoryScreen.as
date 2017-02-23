package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Andre Stackhouse
	 */
	public class VictoryScreen extends World
	{
		private var kartSound:Sfx;
		
		public function VictoryScreen() 
		{
			kartSound = new Sfx(Assets.KARTWINVICTORYYES);
			kartSound.play();
			var victory:Entity = new Entity();
			victory.graphic = new Image(Assets.VICTORY);
			add(victory);
			//Add victory spash screen and "press enter to play again"
		}
		
		override public function update():void
		{
			if (Input.released(Key.ENTER))
			{
				while (GameProperties.GameStates.length > 0)
				{
					GameProperties.GameStates.pop();
				}
				
				GameProperties.newGameState(new MainMenuWorld);
			}
		}
	}
}