package org.opensource.pasut.yus.module.notification
{
	import org.opensource.pasut.yus.Injector;
	import org.opensource.pasut.yus.configuration.InjectionProccessor;
	
	import org.as3commons.reflect.IMetadataContainer;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	
	internal class NotificationInjector implements InjectionProccessor
	{
		public function NotificationInjector()
		{
		}
		
		public function inject(object:Object):Object
		{
			var type:Type = Type.forInstance(object);
			var containers:Array = type.getMetadataContainers("Listener");
			for each(var container:IMetadataContainer in containers){
				if(container is Method){
					injectMethod(container as Method, object);
				}
			}
			return object;
		}
		
		private function injectMethod(method:Method, object:Object):void{
			var parameters:Array = method.parameters;
			if(parameters.length != 1){
				throw new Error("The Method [" + method.name + "] with metadata [Listener] must have only one parameter.");
				return;
			}
			var mapper:NotificationMapper = Injector.getByType(NotificationMapper) as NotificationMapper;
			mapper.map(parameters[0].type.clazz,object,method.name);
		}
	}
}