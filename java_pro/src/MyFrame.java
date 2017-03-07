import javax.swing.JFrame;

public class MyFrame {

	public static void main(String[] args) {
		Student student=new Student("张三");
		System.out.println("student出生时的名字为："+student.getName());
		System.out.println("student开始改名字了~~");
		student.setName("李四");
		System.out.println("student现在的名字为："+student.getName());
		System.out.println("================================我是分格线=========================");
		Student student2=new Student();
		System.out.println("student2出生时的名字为："+student2.getName());
		System.out.println("student2开始起名字了~~");
		student2.setName("雪儿");
		System.out.println("student2现在的名字为："+student2.getName());
	}
}
class Student
{
	private String name;
	public Student() {
		
	}
	public Student(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}