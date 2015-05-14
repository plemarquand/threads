package com.thread.ai
{

	import com.breaktrycatch.color.ColorObject;
	import com.breaktrycatch.color.ColorSpaceTransformations;
	import com.core.ThreadCore;
	import com.thread.constant.ThreadConstants;
	import com.thread.vo.IMotionable;
	import com.util.NumberUtils;
	import com.util.math.Vector2D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author plemarquand
	 */
	public class VectorFieldAgent extends AbstractAgent implements IAgent
	{
		public var seed : Number = 1;
		
		private static var VECTOR_FIELD_SOURCE : BitmapData;
		private static var VECTOR_FIELD : Vector.<Vector2D>;
		private static var VECTOR_FIELD_WIDTH : Number = 800;
		private static var VECTOR_FIELD_HEIGHT : Number = 500;
		
		private var _ctr : Number = 0;

		public function VectorFieldAgent(target : IMotionable)
		{
			super( target );

			VECTOR_FIELD ||= createVectorField();
		}

		override public function randomize() : void
		{
		}

		override public function run() : void
		{
			var x : Number = NumberUtils.wrap( _target.x, ThreadConstants.MANAGER_WIDTH );
			var y : Number = NumberUtils.wrap( _target.y, ThreadConstants.MANAGER_HEIGHT );
			
			x = NumberUtils.map( x, 0, ThreadConstants.MANAGER_WIDTH, 0, VECTOR_FIELD_WIDTH );
			y = NumberUtils.map( y, 0, ThreadConstants.MANAGER_HEIGHT, 0, VECTOR_FIELD_HEIGHT );
			
			var vec : Vector2D = getVector( x, y );
			var angle : Number = Math.atan2( vec.y, vec.x );

			_ctr += .01;
			_target.angle += ( NumberUtils.radToDegree( angle ) - _target.angle ) / (20 + ((Math.sin( _ctr ) + 1) / 2) * 300);
		}

		private function createVectorField() : Vector.<Vector2D>
		{
			VECTOR_FIELD_SOURCE = createVectorFieldSource();

			var field : Vector.<Vector2D> = new Vector.<Vector2D>();

			for (var y : int = 0; y < VECTOR_FIELD_HEIGHT; y++)
			{
				for (var x : int = 0; x < VECTOR_FIELD_WIDTH; x++)
				{
					var pixel : ColorObject = ColorSpaceTransformations.HEXtoRGB( VECTOR_FIELD_SOURCE.getPixel( x, y ) );
					var xC : Number = (pixel.r / 255) * 2 - 1;
					var yC : Number = (pixel.g / 255) * 2 - 1;
					var vec : Vector2D = new Vector2D( xC, yC );

					vec.rotate(seed * NumberUtils.PI_2);
					
					field.push( vec );
				}
			}

			return field;
		}

		private function getVector(x : int, y : int) : Vector2D
		{
			x = NumberUtils.wrap( x, VECTOR_FIELD_WIDTH );
			y = NumberUtils.wrap( y, VECTOR_FIELD_HEIGHT );
			return VECTOR_FIELD[x + y * (VECTOR_FIELD_SOURCE.width - 1)];
		}

		private function createVectorFieldSource() : BitmapData
		{
			var data : BitmapData = new BitmapData( VECTOR_FIELD_WIDTH, VECTOR_FIELD_HEIGHT, false, 0xFFFFFF / 2 );
			data.perlinNoise( VECTOR_FIELD_WIDTH, VECTOR_FIELD_HEIGHT, 7, Math.random() * int.MAX_VALUE, true, true, 7, true, null );

			return data;
		}
	}
}
