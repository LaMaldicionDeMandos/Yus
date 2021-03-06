package org.opensource.pasut.yus.injection
{
	import org.opensource.pasut.yus.Injector;
	import org.opensource.pasut.yus.configuration.InjectionProccessor;
	import org.opensource.pasut.yus.configuration.ProccessorsProxy;

	internal class BeanFactory
	{
		protected var mapping:Mapping;		
		private var _provider:Provider;
		public function BeanFactory(mapping:Mapping){
			if(mapping==null)
				throw new Error("El mapping no puede ser null");
			this.mapping = mapping;
		}
		
		public function getObject():Object{
			var object:Object = createInstance();
			object = provider.inject(object);
			object = delegateInjection(object);
			provider.initObject(object);
			return object;
		}
		
		private function delegateInjection(object:Object):Object{
			var delegators:Array = ProccessorsProxy(Injector.getByName("injectionDelegators")).proccessors as Array;
			for each(var delegator:InjectionProccessor in delegators){
				object = delegator.inject(object);
			}
			return object;
		}
		
		private function get provider():Provider{
			if(_provider==null) _provider = createProvider();
			return _provider;
		}
		
		private function createProvider():Provider{
			if(mapping.toFactory==null)
				return new BasicProvider(mapping.to);
			return new ToFactoryProvider(mapping.toFactory);
		}
		
		private function createInstance():Object{
			return provider.getObject(mapping.customCreator);
		}
	}
}