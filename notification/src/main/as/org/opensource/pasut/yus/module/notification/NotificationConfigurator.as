package org.opensource.pasut.yus.module.notification
{
	import org.opensource.pasut.yus.configuration.Configurator;
	import org.opensource.pasut.yus.injection.Mapper;
	
	internal class NotificationConfigurator implements Configurator
	{
		public function NotificationConfigurator()
		{
		}
		
		public function configure(mapper:Mapper):void
		{
			
			var bus:NotificationManager = new NotificationManager(new NotificationMapperManagerImpl(),new NotificationListenerManagerImpl(), new NotificationCommandManagerImpl());
			mapper.map(NotificationMapper).toInstance(bus);
			mapper.map(NotificationBus).toInstance(bus);
		}
	}
}