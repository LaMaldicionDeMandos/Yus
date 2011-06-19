package org.opensource.pasut.yus.injection
{
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;

	internal class ToFactoryProvider extends Provider
	{
		private var provider:Provider;
		public function ToFactoryProvider(clazz:Class)
		{
			super(clazz);
			provider = new BasicProvider(clazz);
		}
		
		override public function getObject():Object
		{
			var factory:Object = provider.getObject();
			var method:Method = getMethod(factory);
			var arguments:Array = getMethodArguments(method);
			if(method==null) return null;
			return method.invoke(factory,arguments);
		}
		
		private function getMethod(factory:Object):Method{
			var type:Type = Type.forInstance(factory);
			var methods:Array = type.getMetadataContainers("Provider");
			for each(var method:Object in methods){
				if(method is Method)
					return method as Method;
			}
			return null;
		}
		
		private function getMethodArguments(method:Method):Array{
			var metadatas:Array = method.getMetadata("Argument");
			return createArguments(method.parameters,metadatas);
		}
	}
}