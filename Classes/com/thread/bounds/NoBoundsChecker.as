package com.thread.bounds
{

	import com.thread.vo.IMotionable;
	import flash.geom.Point;

	/**
	 * Does nothing.
	 */
	public class NoBoundsChecker extends AbstractBoundsChecker implements IBoundsChecker
	{
		private var _pt : Point = new Point();

		public function NoBoundsChecker(target : IMotionable)
		{
			super( target );
		}

		override public function checkBounds(x : Number, y : Number) : Point
		{
			_pt.x = x;
			_pt.y = y;
			return _pt;
		}
	}
}
