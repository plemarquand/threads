package com.thread.vo
{

	import com.thread.constant.ThreadConstants;
	import com.util.Randomizer;
	import com.util.Rndm;

	/**
	 * @author Paul
	 */
	public class ThreadDataVO implements IMotionable, ILineStyleable, IRandomizable
	{
		private var _x : Number;
		private var _y : Number;
		private var _prevX : Number;
		private var _prevY : Number;
		private var _angle : Number;
		private var _speed : Number;
		private var _lineSize : Number;
		private var _lineAlpha : Number;
		private var _initialSpeed : Number;
		private var _followSpeedRange : Number;
		private var _seed : Number;
		
		private var _startPosVariationX : Number;
		private var _startPosVariationY : Number;
		private var _random : Rndm;

		public function ThreadDataVO(seed :Number)
		{
			prevX = 0;
			prevY = 0;
			_x = 0;
			_y = 0;
			_angle = 0;
			_speed = 1;
			_lineSize = 1;
			_lineAlpha = 1;
			_initialSpeed = 1;
			_followSpeedRange = 0;
			_startPosVariationX = 0;
			_startPosVariationY = 0;
			_seed = seed;
			_random = new Rndm(seed * int.MAX_VALUE);

			randomize();
		}

		public function get x() : Number
		{
			return _x;
		}

		public function get y() : Number
		{
			return _y;
		}

		public function set x(n : Number) : void
		{
			prevX = _x;
			_x = n;
		}

		public function set y(n : Number) : void
		{
			prevY = _y;
			_y = n;
		}

		public function get prevX() : Number
		{
			return _prevX;
		}

		public function get prevY() : Number
		{
			return _prevY;
		}

		public function set prevX(n : Number) : void
		{
			_prevX = n;
		}

		public function set prevY(n : Number) : void
		{
			_prevY = n;
		}

		public function get angle() : Number
		{
			return _angle;
		}

		public function set angle(n : Number) : void
		{
			_angle = n;
		}

		public function get speed() : Number
		{
			return _speed;
		}

		public function set speed(n : Number) : void
		{
			_speed = n;
		}

		public function get lineSize() : Number
		{
			return _lineSize;
		}

		public function set lineSize(n : Number) : void
		{
			_lineSize = n;
		}

		public function get lineAlpha() : Number
		{
			return _lineAlpha;
		}

		public function set lineAlpha(n : Number) : void
		{
			_lineAlpha = n;
		}

		public function get initialSpeed() : Number
		{
			return _initialSpeed;
		}

		public function set initialSpeed(n : Number) : void
		{
			_initialSpeed = n;
			speed = n;
		}

		public function get followSpeedRange() : Number
		{
			return _followSpeedRange;
		}

		public function set followSpeedRange(n : Number) : void
		{
			_followSpeedRange = n;
		}

		public function randomize() : void
		{
			var randomizer : Randomizer = new Randomizer();
			randomizer.addRule( Number, "angle", 267, 273 );
//			randomizer.addRule( Number, "x", 0, ThreadConstants.MANAGER_WIDTH );
//			randomizer.addRule( Number, "y", 0, ThreadConstants.MANAGER_HEIGHT );

			// initial speed should have no variance.
			randomizer.addRule( Number, "initialSpeed", 2, 2 );
			randomizer.addRule( Number, "lineSize", 50, 50 );
			randomizer.addRule( Number, "lineAlpha", .03, .03 );
			randomizer.addRule( Number, "followSpeedRange", .8, .8 );
			
//			randomizer.addRule( Number, "startPosVariationX", ThreadConstants.MANAGER_WIDTH / 2, ThreadConstants.MANAGER_WIDTH / 2 );
//			randomizer.addRule( Number, "startPosVariationY", ThreadConstants.MANAGER_HEIGHT / 2, ThreadConstants.MANAGER_HEIGHT / 2 );

			var x : Number = _random.float( 0, ThreadConstants.MANAGER_WIDTH );
			var y : Number = _random.float( 0, ThreadConstants.MANAGER_HEIGHT );
			
//			randomizer.addRule( Number, 'x', x, x );
//			randomizer.addRule( Number, 'y', y, y );

			_startPosVariationX = 200;
			_startPosVariationY = 200;

			randomizer.randomize( this );

			angle = Math.random() * 360;
			angle -= angle % 90;
		}

		public function get startPosVariationX() : Number
		{
			return _startPosVariationX;
		}

		public function set startPosVariationX(startPosVariationX : Number) : void
		{
			_startPosVariationX = startPosVariationX;
		}

		public function get startPosVariationY() : Number
		{
			return _startPosVariationY;
		}

		public function set startPosVariationY(startPosVariationY : Number) : void
		{
			_startPosVariationY = startPosVariationY;
		}

		public function get seed() : Number
		{
			return _seed;
		}

		public function set seed(seed : Number) : void
		{
			_seed = seed;
		}
	}
}
