package ;
import haxe.unit.TestRunner;

class TestMain 
{
	static public function main()
	{
		var runner = new TestRunner();
		//runner.add(new TestEquality());
		runner.add(new TestUnify());
		runner.run();
	}
}