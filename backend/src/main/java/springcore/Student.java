package springcore;

public class Student {
    private int id;
    private String name;
    private String qualification;
    private Address address;

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public Student(int id, String name, String qualification, Address address) {
        super();
        this.id = id;
        this.name = name;
        this.qualification = qualification;
        this.address = address;
    }

    public Student() {
        super();
    }

    @Override
    public String toString() {
        return "Student [id=" + id + ", name=" + name + ", qualification=" + qualification + "]";
    }
    
}
