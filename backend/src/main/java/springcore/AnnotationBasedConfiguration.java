package springcore;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AnnotationBasedConfiguration {
    public static void main(String[] args) {
try (ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("Spring.xml")) {
    Address add = (Address) context.getBean("address");

    System.out.println("completed");
    System.out.println(add.getCity());
}
}
}