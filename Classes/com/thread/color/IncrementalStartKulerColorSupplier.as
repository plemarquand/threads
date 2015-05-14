package com.thread.color 
{	import com.adobe.kuler.events.ColorRecievedEvent;
	import com.thread.color.KulerColorSupplier;

	/**	 * @author plemarquand	 */	public class IncrementalStartKulerColorSupplier extends KulerColorSupplier 
	{
		private static var _globalCounter : int = 0;
				public function IncrementalStartKulerColorSupplier(initialColors : Array = null, stepSpeed : int = 10)
		{			super( initialColors, stepSpeed );		}
		
		override protected function onResults(event : ColorRecievedEvent) : void
		{
			super.onResults( event );
			
			activeColorIndex = _globalCounter;
			_globalCounter++;
		}
	}}