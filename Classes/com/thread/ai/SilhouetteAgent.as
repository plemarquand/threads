package com.thread.ai
{

	import com.thread.constant.ThreadConstants;
	import com.thread.vo.ThreadDataVO;
	import com.util.NumberUtils;
	import flash.display.BitmapData;

	/**
	 * @author plemarquand
	 */
	public class SilhouetteAgent extends AbstractAgent
	{
		[Inject(name='silhouette')]
		public var silhouette : BitmapData;
		
		private var __forwardLookDistance : Number = 5;

		public function SilhouetteAgent(target : ThreadDataVO)
		{
			super( target );
		}

		override public function run() : void
		{
			super.run();
			
			var rads : Number = NumberUtils.degreeToRad( _target.angle );
			
			var dX : Number = NumberUtils.wrap( _target.x, ThreadConstants.MANAGER_WIDTH );
			var dY : Number = NumberUtils.wrap( _target.y, ThreadConstants.MANAGER_HEIGHT );
			
			dX = NumberUtils.map(dX, 0, ThreadConstants.MANAGER_WIDTH, 0, silhouette.width);
			dY = NumberUtils.map(dY, 0, ThreadConstants.MANAGER_HEIGHT, 0, silhouette.height);
			
			var startRads : Number = rads;
			var ctr : int = 0;
			
			do
			{
				var nX : Number = dX + Math.round( Math.cos( rads ) * __forwardLookDistance );
				var nY : Number = dY + Math.round( Math.sin( rads ) * __forwardLookDistance );
				var pix : uint = silhouette.getPixel( nX, nY );
				ctr ++;
				rads += Math.PI / 16;
			}
			while (pix > 0xffffffff /2 && rads < startRads + NumberUtils.PI_2);
			
			_target.angle += ( NumberUtils.radToDegree(rads) - _target.angle ) / 4;
			
		}

		override public function randomize() : void
		{
			super.randomize();
		}
	}
}
