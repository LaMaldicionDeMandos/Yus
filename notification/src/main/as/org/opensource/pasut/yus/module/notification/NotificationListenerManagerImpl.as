package org.opensource.pasut.yus.module.notification
{
	import flash.utils.Dictionary;

	internal class NotificationListenerManagerImpl implements NotificationListenerManager
	{
		private var listeners:Dictionary;
		
		public function NotificationListenerManagerImpl()
		{
			listeners = new Dictionary();
		}
		
		public function addListener(messageClass:Class, listener:Function):void
		{
			var _listeners:Array = listeners[messageClass];
			if(_listeners == null){
				_listeners = [];
				listeners[messageClass] = _listeners;
			}
			_listeners.push(listener);
		}
		
		public function dispatch(message:Object,clazz:Class):void
		{
			for each(var listener:Function in listeners[clazz]){
				listener(message);
			}
		}
	}
}