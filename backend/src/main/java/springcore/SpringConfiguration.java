package springcore;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringConfiguration {
@Bean(name="address")
public Address getAddress() {
	return new Address();
}
@Bean(name="addressc")
public Address getAddressc() {
	return new Address(1,"BHEL","HYD");
}
}
