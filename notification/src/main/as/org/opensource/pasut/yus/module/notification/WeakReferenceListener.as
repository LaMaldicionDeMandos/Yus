package org.opensource.pasut.yus.module.notification
{
	import org.opensource.pasut.yus.utils.WeakReferenceObject;
	
	import flash.utils.Dictionary;
	
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;

	internal class WeakReferenceListener extends WeakReferenceObject
	{
		public function WeakReferenceListener(weakObject:Object, listenerName:String)
		{
			super(weakObject);
			map[weakObject] = listenerName;
		}
		
		public function get listenerName():String{
			for(var item:Object in map){
				return map[item];
			}
			return null;
		}
		
		public function perform(message:Object):Boolean{
			if(reference==null) return false;
			var method:Method = getMethod();
			method.invoke(reference,[message]);
			return true;
		}
		
		private function getMethod():Method{
			var type:Type = Type.forInstance(reference);
			return type.getMethod(listenerName);
		}
	}
}