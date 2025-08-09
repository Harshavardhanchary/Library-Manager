package springcore;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class FirstSpringApp {
    @SuppressWarnings("resource")
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        Student st1 = (Student) context.getBean("sts");
        System.out.println("Student 1 Name: " + st1.getName());
        Student st2 = (Student) context.getBean("stc");
        Address add = (Address) context.getBean("address");
        System.out.println("Address City: " + add.getCity());
        System.out.println("completed");
        System.out.println(st2.getName());
        System.out.println(st2.getAddress().getCity());
    }
}
