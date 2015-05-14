package com.thread.factory
{

	import com.thread.Thread;
	import com.thread.ai.BitmapFollowAgent;
	import com.thread.ai.FollowAgent;
	import com.thread.ai.GroupFollowAgent;
	import com.thread.ai.IAgent;
	import com.thread.ai.RightAngleAgent;
	import com.thread.bounds.BounceBoundsChecker;
	import com.thread.bounds.IBoundsChecker;
	import com.thread.color.IColorSupplier;
	import com.thread.color.KulerColorSupplier;
	import com.thread.constant.ThreadConstants;
	import com.thread.draw.IDrawer;
	import com.thread.draw.SimpleDrawer;
	import com.thread.line.IDrawStyle;
	import com.thread.line.SimpleLine;
	import com.thread.transform.IDrawTransform;
	import com.thread.transform.RibbonTransform;
	import com.thread.transform.SimpleTransform;
	import com.thread.vo.ThreadDataVO;
	import org.swiftsuspenders.Injector;
	import flash.display.BitmapData;

	/**
	 * @author Paul
	 */
	public class ThreadFactory
	{
		private var _threadCount : int = 0;
		private var _seed : Number = Math.random();

		private function createThreadVO() : ThreadDataVO
		{
			var vo : ThreadDataVO = new ThreadDataVO(Math.random());
			vo.angle = 360 * _seed;
			vo.x = ThreadConstants.MANAGER_WIDTH / 2;
			vo.y = ThreadConstants.MANAGER_HEIGHT / 2;
			vo.lineAlpha = .5;
			vo.lineSize = 5;
			vo.initialSpeed = 2.7;
			return vo;
		}

		public function getSimpleThread() : Thread
		{
			var vo : ThreadDataVO = createThreadVO();
			var injector : Injector = new Injector();
			injector.mapClass( IDrawer, SimpleDrawer );
			injector.mapClass( IDrawStyle, SimpleLine );
			injector.mapClass( IDrawTransform, RibbonTransform );
			injector.mapClass( IColorSupplier, KulerColorSupplier );
			injector.mapClass( IBoundsChecker, BounceBoundsChecker );
			injector.mapValue( ThreadDataVO, vo );
			var thread : Thread = injector.instantiate( Thread );
			return thread;
			/*
			var colorSupplier : IColorSupplier = new KulerColorSupplier( [ 0xff0000, 0x00ff00, 0x0000ff ], 200 );
			var transform : IDrawTransform = new RibbonTransform( 10, 5 );
			var drawer : IDrawer = new SimpleDrawer();

			_threadList ||= new Vector.<ThreadDataVO>();

			var motionAI : IAgent = (_threadCount % GroupFollowAgent.GROUP_SIZE == 0) ? (new RightAngleAgent( vo )) : (new GroupFollowAgent( vo, _threadList[_threadList.length - 1], ( _threadList.length % GroupFollowAgent.GROUP_SIZE) / GroupFollowAgent.GROUP_SIZE ));
			_threadList.push( vo );

			motionAI.randomize();
			if (motionAI is RightAngleAgent)
			{
				vo.lineAlpha = 0;
			}
 
			var boundsChecker : IBoundsChecker = new BounceBoundsChecker( vo );
			var lineStyle : IDrawStyle = new SimpleLine( vo, colorSupplier );

			_threadCount++;

			return new Thread( vo, boundsChecker, colorSupplier, transform, drawer, lineStyle, motionAI );*/
		}

		public function getAlphabetThread(letterData : BitmapData) : Thread
		{
			var vo : ThreadDataVO = new ThreadDataVO();
			vo.angle = 0;
			vo.x = ThreadConstants.MANAGER_WIDTH / 2;
			// * Math.random( );
			vo.y = ThreadConstants.MANAGER_HEIGHT / 2;
			// * Math.random( );
			vo.lineAlpha = .1;
			vo.lineSize = 2;
			vo.initialSpeed = .8;

			var colorSupplier : IColorSupplier = new KulerColorSupplier( [ 0xff0000, 0x00ff00, 0x0000ff ], 50 + _threadCount );
			// var drawer : IDrawer = new KaleidoscopeDrawer( 5 );
			var transform : IDrawTransform = new SimpleTransform();
			var drawer : SimpleDrawer = new SimpleDrawer();

			var motionAI : IAgent = (_threadCount == 0) ? (new BitmapFollowAgent( vo, letterData )) : (new FollowAgent( vo ));
			motionAI.randomize();

			var boundsChecker : IBoundsChecker = new BounceBoundsChecker( vo );
			var lineStyle : IDrawStyle = new SimpleLine( vo, colorSupplier );

			_threadCount++;

			return new Thread( vo, boundsChecker, colorSupplier, transform, drawer, lineStyle, motionAI,  );
		}
		// public function getAlphabetThread(letterData : BitmapData) : Thread
		// {
		// var vo : ThreadDataVO = new ThreadDataVO( );
		// vo.angle = 0
		// vo.x = ThreadConstants.MANAGER_WIDTH / 2;
		// vo.y = ThreadConstants.MANAGER_HEIGHT / 2;
		// vo.lineAlpha = 1;
		// vo.lineSize = 1;
		// vo.speed = 1.2;
		//			
	// var colorSupplier : IColorSupplier = new KulerColorSupplier( [0xff0000, 0x00ff00, 0x0000ff], 10 );
	// var drawer : IDrawer = new SimpleDrawer( );
	//			//  var motionAI : IAgent = (_threadCount == 0) ? (new BitmapFollowAgent( vo, letterData )) : (new FollowAgent( vo ));
	// var motionAI : IAgent = (_threadCount == 0) ? (new SimpleAgent( vo )) : (new FollowAgent( vo ));
	//
	// var boundsChecker : IBoundsChecker = new BounceBoundsChecker( );
	// boundsChecker.target = vo;
	//			
	// var lineStyle : IDrawStyle = new SizedAlphaLine( );
	// lineStyle.colorSupplier = colorSupplier;
	// lineStyle.target = vo;
	//			
	// _threadCount++;
	//			
	// return new Thread( vo, boundsChecker, colorSupplier, drawer, lineStyle, motionAI );	
	// }
	}
}
