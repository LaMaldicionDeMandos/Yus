package org.opensource.pasut.yus.module.notification
{
	import flash.utils.Dictionary;

	internal class NotificationMapperManagerImpl implements NotificationMapperManager
	{
		private var _map:Dictionary;
		
		public function NotificationMapperManagerImpl()
		{
			_map = new Dictionary();
		}
		
		public function map(message:Class, listener:Object, handlerName:String):void
		{
			var listeners:Array = _map[message];
			if(listeners == null){
				listeners = [];
				_map[message] = listeners;
			}
			listeners.push(new WeakReferenceListener(listener,handlerName));
		}
		
		public function dispatch(message:Object, clazz:Class):void
		{
			for each(var handler:WeakReferenceListener in _map[clazz]){
				handler.perform(message);
			}
		}
	}
}