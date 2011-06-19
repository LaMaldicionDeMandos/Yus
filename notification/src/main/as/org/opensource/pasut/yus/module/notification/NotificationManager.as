package org.opensource.pasut.yus.module.notification
{
	import flash.utils.Dictionary;
	
	import org.as3commons.reflect.Type;
	import org.osmf.proxies.ListenerProxyElement;

	public class NotificationManager implements NotificationMapper, NotificationBus
	{
		private var mapManager:NotificationMapperManager;
		private var listenersManager:NotificationListenerManager;
		private var commandManager:NotificationCommandManager;
		
		public function NotificationManager(mapperManager:NotificationMapperManager, listenerManager:NotificationListenerManager, commandManager:NotificationCommandManager)
		{			
			mapManager = mapperManager;
			listenersManager = listenerManager;
			this.commandManager = commandManager;
		}
		
		public function dispatch(message:Object):void
		{
			dispatchByClass(message);
			dispatchBySuperClasses(message);
			dispatchByInterfaces(message);
		}
		
		public function map(message:Class, listener:Object, handlerName:String):void
		{
			mapManager.map(message,listener,handlerName);
		}
		
		public function addListener(message:Class,listener:Function):void{
			listenersManager.addListener(message,listener);
		}
		
		public function addCommand(message:Class, command:Class):void{
			commandManager.addCommand(message,command);
		}
		
		private function dispatchByClass(message:Object):void{
			var type:Type = Type.forInstance(message);
			dispatchListeners(message,type.clazz);
			dispatchHandlers(message, type.clazz);
			dispatchCommands(message, type.clazz);
		}
		
		private function dispatchBySuperClasses(message:Object):void{
			var type:Type = Type.forInstance(message);
			for each(var clazz:String in type.extendsClasses){
				var superType:Type = Type.forName(clazz);
				dispatchListeners(message,superType.clazz);
				dispatchHandlers(message, superType.clazz);
				dispatchCommands(message, superType.clazz);
			}
		}
		
		private function dispatchByInterfaces(message:Object):void{
			var type:Type = Type.forInstance(message);
			for each(var clazz:String in type.interfaces){
				var interfaceType:Type = Type.forName(clazz);
				dispatchListeners(message,interfaceType.clazz);
				dispatchHandlers(message, interfaceType.clazz);
				dispatchCommands(message, interfaceType.clazz);
			}
		}
		
		private function dispatchCommands(message:Object, clazz:Class):void{
			commandManager.dispatch(message, clazz);
		}
		
		private function dispatchHandlers(message:Object, clazz:Class):void{
			mapManager.dispatch(message,clazz);
		}
		
		private function dispatchListeners(message:Object,clazz:Class):void{
			listenersManager.dispatch(message,clazz);
		}
	}
}