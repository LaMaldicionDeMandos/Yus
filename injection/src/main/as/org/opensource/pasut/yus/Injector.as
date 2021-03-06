package org.opensource.pasut.yus
{
	import org.opensource.pasut.yus.configuration.Configurator;
	import org.opensource.pasut.yus.configuration.InjectionModule;

	public class Injector
	{
		private static var _ioc:IOCContainer;
		
		public static function install(configurator:Configurator):void{
			ioc.install(configurator);
		}
				
		public static function getByType(clazz:Class):Object{
			return ioc.getByType(clazz);
		}
		
		public static function getByName(name:String):Object{
			return ioc.getByName(name);
		}
		
		private static function get ioc():IOCContainer{
			if(_ioc==null) _ioc = new IOCContainer();
			return _ioc;
		}
		
		public static function addModule(module:InjectionModule):void{
			ioc.addModule(module);
		}
		
	}
}