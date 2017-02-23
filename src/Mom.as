package  
{
	import flash.events.ContextMenuEvent;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Grant Wu
	 */
	public class Mom extends WalkingObject
	{
		private var weapon:Gun;
		private var directionCounter:Number;
		private var direction:int;
		private var leftBound:Number;
		private var rightBound:Number;
		private var attacking:Boolean;
		private var hp:Number;
		private var shitToSay:Vector.<String>;
		private var graphicList:Graphiclist;
		private var textCooldown:Number;
		private var text:Text;
		private var spriteMap:Spritemap;
		private var shitCtr:int;
		
		public function Mom() 
		{
			shitToSay = new < String > ["Be careful!", 
				"Don't go too for into the forest!", 
				"It's getting dark out!", 
				"Don't forget to take your gun!",
				"The bandages are in the workbench."
			];
			
			spriteMap = new Spritemap(Assets.MOMIMAGE, 110, 133);
			spriteMap.add("idle", [0], 1);
			spriteMap.add("move", [2, 3], 10);
			gravity = true;
			shitCtr = 0;
			textCooldown = 0;
			text = new Text(new String("                                                        "));
			text.visible = true;
			graphicList = new Graphiclist(spriteMap, text);
			direction = 1;
			directionCounter = 0;
			super (5.0, 200);
			weapon = new Shotgun();
			leftBound = 50;
			rightBound = 750;
			graphic = graphicList;
			setHitbox(40, 133, -5);
			x = 400;
			y = 300;
			hp = 200;
			height = 133;
			width = 100;
			type = "mom"
		}
		
		override public function update():void
		{
			determineDirection();
			super.update();
			enforceBounds();
			weapon.update();
			if (textCooldown > 0)
			{
				text.visible = true;
				textCooldown -= FP.elapsed;
			}
			else
			{
				text.visible = false;
			}
		}
		
		private function enforceBounds():void 
		
		{
			if (x + width > rightBound)
			{
				x = rightBound - width - 1;
				spriteMap.play("idle");
			}
			
			if (x < leftBound)
			{
				x = leftBound + 1;
				spriteMap.play("idle");
			}
		}
		
		private function determineDirection():void
		{
			var target:Entity = FP.world.nearestToEntity("enemy", this);

			if (target && distanceFrom(target) < 400)
			{
				var facing:Number = (target.x - x) / Math.abs(target.x - x);
				if (facing < 0)
				{
					spriteMap.flipped = true;
				}
				else if(facing > 0)
				{
					spriteMap.flipped = false;
				}
				
				if (target.y < 350)
				{
					weapon.Fire(x + width / 2, y + height / 2, (target.x - x) / Math.abs(target.x - x), 1);
				}
				else
				{
					weapon.Fire(x + width / 2, y + height / 2, (target.x - x) / Math.abs(target.x - x), 0);
				}
				spriteMap.play("idle");
				Stop();
			}
			else
			{
				directionCounter += FP.elapsed;
				if (directionCounter > 10)
				{
					direction *= -1
					directionCounter = 0;
					if (direction == 1)
					{
						spriteMap.flipped = false;
					}
					else 
					{
						spriteMap.flipped = true;
					}
				}
				
				spriteMap.play("move");
				receiveForce(direction * 300, 0);
			}
		}
//<<<<<<< HEAD
//=======

		public function sayShit():void
		{
			if (textCooldown <= 0)
			{
				text.x = x;
				text.y = y - text.height - 2
				textCooldown = 10;
				text.text = shitToSay[shitCtr++];
				text.visible = true;
				if (shitCtr > 4)
				{
					shitCtr = 0;
				}
			}
		}
//>>>>>>> d2255c26889fa0efbfc3cfb6b2e4d842d8408aa6
	}
}