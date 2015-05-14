package com.thread.line
{

	import com.thread.color.IColorSupplier;
	import com.thread.vo.ILineStyleable;
	import flash.display.Sprite;

	/**
	 * @author plemarquand
	 */
	public class OscillatingSizedLine extends AbstractLineStyle implements IDrawStyle
	{
		private var _index : int;
		private var _worldAgents : Array;
		private var _ctr : Number = 0;

		public function OscillatingSizedLine(target : ILineStyleable, colorSupplier : IColorSupplier)
		{
			super( target, colorSupplier, this );
		}

		override public function preDraw(drawTarget : Sprite) : void
		{
			_ctr += .05;
			var perc : Number = _index / _worldAgents.length;
			var inverse : Number = 1 - perc;
			var oscillation : Number = (Math.sin( _ctr ) + 1 / 2) + 2;
			var size : Number = oscillation * _target.lineSize * inverse;

			drawTarget.graphics.lineStyle( size, _colorSupplier.currentColor, _target.lineAlpha );
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
