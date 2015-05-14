package com.thread.ai
{

	import com.thread.ai.AbstractAgent;
	import com.thread.vo.IMotionable;

	/**
	 * @author plemarquand
	 */
	public class CircleAgent extends AbstractAgent implements IAgent
	{
		private var _angleIncrement : Number = 2;
		private var _ctr : Number = 0;

		public function CircleAgent(target : IMotionable)
		{
			super( target );
		}

		override public function run() : void
		{
			_target.angle += _angleIncrement;

			_ctr ++;
			_angleIncrement = Math.cos( Math.random() * _ctr ) * 2;

			super.run();
		}
	}
}
