package com.thread.factory
{

	import com.thread.ai.VectorFieldAgent;
	import com.thread.ai.SimpleAgent;
	import com.thread.transform.SimpleTransform;
	import com.breaktrycatch.collection.util.ArrayExtensions;
	import com.thread.Thread;
	import com.thread.ai.IAgent;
	import com.thread.ai.SilhouetteAgent;
	import com.thread.bounds.IBoundsChecker;
	import com.thread.bounds.NoBoundsChecker;
	import com.thread.color.IColorSupplier;
	import com.thread.color.ImageColorSupplier;
	import com.thread.draw.IDrawer;
	import com.thread.draw.InfinitePlaneDrawer;
	import com.thread.line.AngleBasedSizedLine;
	import com.thread.line.IDrawStyle;
	import com.thread.transform.IDrawTransform;
	import com.thread.transform.MirrorXTransform;
	import com.thread.vo.ILineStyleable;
	import com.thread.vo.IMotionable;
	import com.thread.vo.ThreadDataVO;
	import com.util.Profiler;
	import com.util.Rndm;
	import org.swiftsuspenders.Injector;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**	 * @author plemarquand	 */
	public class RandomThreadFactory
	{
		[Embed(source="../bin/images/C_PNG.png")]
		public var silhouette : Class; 
		
		[Embed(source="../bin/images/tumblr_lzulsjyMne1r3m9qso1_1280.jpeg")]
		public var image : Class;
		
		private var _agents : Array = [ VectorFieldAgent ]; // [FollowAgent];//[RightAngleFollowAgent];//[UniqueLeaderFollowAgent];//[SimpleAgent, CurvyAgent, FollowAgent, GroupFollowAgent, RightAngleAgent];
		private var _colours : Array = [ ImageColorSupplier ]; // [GradientColorSupplier, IncrementalStartKulerColorSupplier, KulerColorSupplier, RandomKulerColorSupplier];//[SimpleColorSupplier, GradientColorSupplier, IncrementalStartKulerColorSupplier, KulerColorSupplier, RandomKulerColorSupplier];
		private var _drawers : Array = [ InfinitePlaneDrawer ]; // , CircleDrawer, PolyDrawer, ProximityPolyDrawer, SquareDrawer];
		private var _transformers : Array = [ SimpleTransform ];//MirrorXTransform, MirrorYTransform ]//, SimpleTransform, MirrorTransform]; 
		private var _bounds : Array = [ NoBoundsChecker ]; // [BounceBoundsChecker, ContinuationBoundsChecker, RandomAngleBoundsChecker];
		private var _styles : Array = [ AngleBasedSizedLine ]; // [AlphaLine, FaintLine, FillShapeStyle, SimpleLine, SizedAlphaLine, SizedLine];
		private var __profiler : Profiler;
		private var __seed : Number;

		public function RandomThreadFactory(_profiler : Profiler, _seed : Number)
		{
			__profiler = _profiler;
			__seed = _seed;
		}

		public function randomize() : void
		{
		}

		public function getThread() : Thread
		{
			var vo : ThreadDataVO = new ThreadDataVO( __seed );

			vo.lineSize = new Rndm( __seed * int.MAX_VALUE ).random() * vo.lineSize + 5;
			
			var injector : Injector = new Injector();
			injector.mapClass( Thread, Thread );
			injector.mapClass( IAgent, ArrayExtensions.randomElement( _agents ) );
			injector.mapSingletonOf( IColorSupplier, ArrayExtensions.randomElement( _colours ) );
			injector.mapClass( IDrawer, ArrayExtensions.randomElement( _drawers ) );
			injector.mapClass( IDrawTransform, ArrayExtensions.randomElement( _transformers ) );
			injector.mapClass( IBoundsChecker, ArrayExtensions.randomElement( _bounds ) );
			injector.mapClass( IDrawStyle, ArrayExtensions.randomElement( _styles ) );
			injector.mapValue( IMotionable, vo );
			injector.mapValue( ILineStyleable, vo );
			injector.mapValue( Profiler, __profiler );
			injector.mapValue( ThreadDataVO, vo );
			injector.mapValue( Number, __seed );
			injector.mapValue( BitmapData, (new image() as Bitmap).bitmapData );
			injector.mapValue( BitmapData, (new silhouette() as Bitmap).bitmapData, 'silhouette' );
			
			var thread : Thread = injector.getInstance( Thread );
			
//			vo.x = ThreadConstants.MANAGER_WIDTH / 2 + vo.startPosVariationX * __seed - vo.startPosVariationX * __seed;
//			vo.y = ThreadConstants.MANAGER_HEIGHT / 2 + vo.startPosVariationY * __seed - vo.startPosVariationY * __seed;
			
			// so so so slow!
//			ArrayExtensions.executeCallbackOnArray( ReflectionUtils.getAllObjectsOfType( thread, IRandomizable, true ), 'randomize' );
			return thread;
		}
	}
}
