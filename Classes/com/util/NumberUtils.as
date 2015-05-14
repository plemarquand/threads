package com.util
{

	import flash.geom.Point;

	/**
	 * A set of Number helper methods
	 */
	public class NumberUtils
	{
		public static const PI_2 : Number = Math.PI * 2;
		public static const PI_HALF : Number = Math.PI / 2;

		public static function sign(num : Number) : Number
		{
			return (num >= 0) ? (1) : (-1);
		}

		/**
		 * Constrains a number between a given range
		 * @param num The number to constrain
		 * @param min The minimum number in the range
		 * @param max The maximum number in the range
		 * @return The constrained number
		 */
		public static function constrain(num : Number, min : Number, max : Number) : Number
		{
			return( Math.max( min, Math.min( num, max ) ) );
		}

		/**
		 * Returns a random number between 2 given values
		 * @param min The minimum number in the range
		 * @param max The maximum number in the range
		 * @return The random number
		 */
		public static function randomBetween(low : int, high : int) : int
		{
			return( Math.round( Math.random() * (high - low) ) + low );
		}

		/**
		 * Retruns a String with added zeros to the begging.
		 * Comes in handy when wanting to right justify numbers in a textfield or in a countdown.
		 * @param num The number to add Zeros to
		 * @param amount The amount of zeros to pad
		 * @return A new string with the added zeros at the start of the number
		 */
		public static function padZero(num : Number, amount : Number) : String
		{
			var str : String = String( num );
			while ( str.length < amount )
			{
				str = '0' + str;
			}

			return( str );
		}

		/**
		 * Returns the milliseconds when you pass it a time stamp string
		 * hh:mm:ss:ms
		 * 
		 * @param string The time stamp string to be converted ( hh:mm:ss:ms)
		 * @return A number representing the milliseconds the timestamp would have
		 */
		public static function getMSFromTimestamp(p_time : String) : Number
		{
			var match : Object = /(\d+):(\d+):(\d+)(:(\d+))?/.exec( p_time );

			var h : Number = (parseInt( match[1] ) || 0) * 60 * 60 * 1000;
			var m : Number = (parseInt( match[2] ) || 0) * 60 * 1000;
			var s : Number = (parseInt( match[3] ) || 0) * 1000;
			var ms : Number = (parseInt( match[5] ) || 0);

			return h + m + s + ms;
		}
		
		public static function map(val : Number, currMin:  Number, currMax : Number, newMin : Number, newMax : Number) : Number
		{
			var perc : Number = (val - currMin) / (currMax - currMin);
			return newMin + perc * (newMax - newMin); 
		}

		public static function degreeToRad(deg : Number) : Number
		{
			return deg * (Math.PI / 180);
		}

		public static function radToDegree(rad : Number) : Number
		{
			return rad * ( 180 / Math.PI);
		}

		public static function dotProduct(v1 : Point, v2 : Point) : Number
		{
			return (v1.x * v2.x + v1.y * v2.y);
		}
		
		public static function distance(x1 : Number, y1 : Number, x2: Number, y2: Number) : Number
		{
			return Math.sqrt( (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) );
		}

		/**
		 * Unwraps an angle to a value within one rotation (2PI or 360) either +ve or -ve
		 * 
		 * @param angle The angle to unwrap
		 * @param useRadians specifies if radians are being used or not
		 * @return The unwrapped angle
		 */
		public static function unWrapAngle(_angle : Number, _useRadians : Boolean = false) : Number
		{
			var fullCircle : Number = (_useRadians) ? PI_2 : 360;

			while (_angle > fullCircle) _angle -= fullCircle;
			while (_angle < 0) _angle += fullCircle;

			return _angle;
		}

		public static function wrap(value : Number, range : Number) : Number
		{
			var x : Number = value % range;
			if(x < 0) {
				x = range + x;
			}
			return x;
		}
	}
}