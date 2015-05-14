package com.thread.ai
{

	import com.thread.vo.IMotionable;

	/**
	 * @author Paul
	 */
	public class FollowAgent extends AbstractAgent implements IAgent
	{
		private var _ctr : int = 1000;

		public function FollowAgent(target : IMotionable)
		{
			super( target );
			_target.angle += Math.PI;
		}

		override public function randomize() : void
		{
		}

		override public function run() : void
		{
			_ctr += 1;
			_target.angle += Math.sin(_ctr / 100) * 2;
			
			if (_ctr % 1000 == 0)
			{
				_target.angle += ((Math.random() < .5) ? (-1) : (1)) * 45;
				super.run();
			}
		}
	}
}
