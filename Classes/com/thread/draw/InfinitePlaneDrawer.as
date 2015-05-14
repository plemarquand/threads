package com.thread.draw
{

	import com.util.NumberUtils;
	import flash.utils.Dictionary;
	import com.geom.Line;
	import com.thread.constant.ThreadConstants;
	import com.thread.vo.ThreadDataVO;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author plemarquand
	 */
	public class InfinitePlaneDrawer extends AbstractDrawer implements IDrawer
	{
		private var __stageRect : Rectangle;

		public function InfinitePlaneDrawer()
		{
			super();
			__stageRect = new Rectangle( 0, 0, ThreadConstants.MANAGER_WIDTH, ThreadConstants.MANAGER_HEIGHT );
		}

		private var __lookup : Dictionary = new Dictionary();

		override public function draw(drawTarget : Sprite, lines : Array) : void
		{
			var len : int = lines.length;
			for (var i : Number = 0; i < len ; i++)
			{
				var line : Line = lines[i];
				var pt1 : Point = line.pt1;
				var pt2 : Point = line.pt2;

				__lookup[i] ||= new Point();

				var tracker : Point = __lookup[i];

				var isDirty : Boolean = false;
				if (pt1.x < tracker.x)
				{
					tracker.x -= ThreadConstants.MANAGER_WIDTH;
					isDirty = true;
				}
				else if (pt1.x > tracker.x + ThreadConstants.MANAGER_WIDTH)
				{
					tracker.x += ThreadConstants.MANAGER_WIDTH;
					isDirty = true;
				}

				if (pt1.y < tracker.y)
				{
					tracker.y -= ThreadConstants.MANAGER_HEIGHT;
					isDirty = true;
				}
				else if (pt1.y > tracker.y + ThreadConstants.MANAGER_HEIGHT)
				{
					tracker.y += ThreadConstants.MANAGER_HEIGHT;
					isDirty = true;
				}
				
				var p1x : Number = NumberUtils.wrap( pt1.x, ThreadConstants.MANAGER_WIDTH );
				var p2x : Number = NumberUtils.wrap( pt2.x, ThreadConstants.MANAGER_WIDTH );
				
				var p1y : Number = NumberUtils.wrap( pt1.y, ThreadConstants.MANAGER_HEIGHT );
				var p2y : Number = NumberUtils.wrap( pt2.y, ThreadConstants.MANAGER_HEIGHT );

				if (Math.abs( p1x - p2x ) < ThreadConstants.MANAGER_WIDTH * .75 && 
					Math.abs( p1y - p2y ) < ThreadConstants.MANAGER_HEIGHT * .75 )
				{
					drawTarget.graphics.moveTo( p1x, p1y );
					drawTarget.graphics.lineTo( p2x, p2y );
				}
			}
		}

		override public function randomize() : void
		{
			// do nothing
		}
	}
}
