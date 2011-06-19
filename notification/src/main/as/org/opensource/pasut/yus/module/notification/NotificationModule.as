package org.opensource.pasut.yus.module.notification
{
	import org.opensource.pasut.yus.configuration.Configurator;
	import org.opensource.pasut.yus.configuration.InjectionModule;
	import org.opensource.pasut.yus.configuration.InjectionProccessor;
	import org.opensource.pasut.yus.configuration.MappingProccessor;
	
	public class NotificationModule implements InjectionModule
	{
		public function NotificationModule()
		{
		}
		
		public function get configurator():Configurator
		{
			return new NotificationConfigurator();
		}
		
		public function get injectionProccessors():Array
		{
			return [new NotificationInjector()];
		}
		
		public function get mappingProccessors():Array
		{
			return [new CommandProccessor()];
		}
	}
}