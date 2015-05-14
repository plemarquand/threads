package com.thread.draw 
{

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	{				
		public function CircleDrawer() 
		{
			super();
		}
		
		override public function draw(drawTarget : Sprite, lines : Array) : void
		{
			var len : int = lines.length;
			for (var i : Number = 0; i < len; i++) 
			{
				var midPt : Point = lines[i].interpolate(.5);
				var radius : Number = lines[i].length / 2;
				
				drawTarget.graphics.drawCircle( midPt.x, midPt.y, radius);
			}
		}

			// do nothing
	}