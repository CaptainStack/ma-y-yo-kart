package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public interface Gun
	{		
		function Fire(x:int, y:int, facing:int, vertical:int):void
		
		function update():void
	}

}