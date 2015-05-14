package com.thread.color
{

	import com.breaktrycatch.color.ColorUtil;
	import com.thread.constant.ThreadConstants;
	import com.util.NumberUtils;
	import com.thread.vo.ThreadDataVO;
	import flash.display.BitmapData;

	/**
	 * @author plemarquand
	 */
	public class ImageColorSupplier implements IColorSupplier
	{
		[Inject]
		public var image : BitmapData;
		
		[Inject]
		public var data : ThreadDataVO;
		private var __currentColor : uint;
		
		public function update() : void
		{
			var lastColor : Number = __currentColor;
			
			var dX : Number = NumberUtils.wrap( data.x, ThreadConstants.MANAGER_WIDTH );
			var dY : Number = NumberUtils.wrap( data.y, ThreadConstants.MANAGER_HEIGHT );

			dX = NumberUtils.map( dX, 0, ThreadConstants.MANAGER_WIDTH, 0, image.width );
			dY = NumberUtils.map( dY, 0, ThreadConstants.MANAGER_HEIGHT, 0, image.height );

			var newColor : Number = image.getPixel32( dX, dY );
			__currentColor = ColorUtil.blendRGB( lastColor, newColor, .1 );

			//
		}

		public function copy() : IColorSupplier
		{
			return new ImageColorSupplier();
		}

		public function get currentColor() : uint
		{
			return __currentColor;
		}

		public function get framesPerColor() : uint
		{
			// TODO: Auto-generated method stub
			return 0;
		}

		public function set framesPerColor(n : uint) : void
		{
		}
	}
}
