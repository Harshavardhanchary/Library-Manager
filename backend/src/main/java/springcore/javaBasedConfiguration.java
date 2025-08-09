package springcore;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class javaBasedConfiguration {
public static void main(String args[]) {
	try (AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(SpringConfiguration.class)) {
		Address add = (Address) context.getBean("address");
		System.out.println(add.getCity());
		Address add2 = (Address) context.getBean("addressc");
		System.out.println(add2.getCity());
		System.out.println("Completed");
	}
}
}
