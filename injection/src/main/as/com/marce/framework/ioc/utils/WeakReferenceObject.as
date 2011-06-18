package com.marce.framework.ioc.utils
{
	import flash.utils.Dictionary;

	public class WeakReferenceObject
	{
		protected var map:Dictionary;
		public function WeakReferenceObject(weakObject:Object)
		{
			map = new Dictionary(true);
			map[weakObject] = true;
		}
		
		public function get reference():Object{
			for(var item:Object in map){
				return item;
			}
			return null;
		}
	}
}

