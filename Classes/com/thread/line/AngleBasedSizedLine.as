package com.thread.line
{

	import com.util.NumberUtils;
	import com.thread.Thread;
	import com.thread.color.IColorSupplier;
	import com.thread.vo.ILineStyleable;
	import flash.display.Sprite;

	/**
	 * @author plemarquand
	 */
	public class AngleBasedSizedLine extends AbstractLineStyle implements IDrawStyle
	{
		private var _index : int;
		private var _worldAgents : Array;
		private var _lastAngle : Number = 0;
		private var _ctr : Number = 0;

		public function AngleBasedSizedLine(target : ILineStyleable, colorSupplier : IColorSupplier)
		{
			super( target, colorSupplier, this );
		}

		override public function preDraw(drawTarget : Sprite) : void
		{
			var thread : Thread = _worldAgents[_index];
			// offsets the fact that when threads are created they are all on top of each other, and their angles go crazy for a sec.
			if ( _ctr < 100)
			{
				_lastAngle = thread.data.angle;
				_ctr++;
				drawTarget.graphics.lineStyle( 1, _colorSupplier.currentColor, 0 );
			}
			else
			{
				var perc : Number = _index / _worldAgents.length;
				var inverse : Number = 1 - perc;
				var size : Number = Math.abs( ((thread.data.angle - _lastAngle) / NumberUtils.PI_2) * _target.lineSize * 50 * inverse );

				_lastAngle = thread.data.angle;

				drawTarget.graphics.lineStyle( Math.min( Math.max(5 * inverse, size), _target.lineSize), _colorSupplier.currentColor, _target.lineAlpha );
			}
		}

		override public function postDraw(drawTarget : Sprite) : void
		{
		}

		override public function setModifiers(...args) : void
		{
			_worldAgents = args[0];
			_index = args[1];
		}
	}
}
