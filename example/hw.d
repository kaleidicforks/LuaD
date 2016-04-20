import luad.all;
import std.stdio;
import std.variant;
import std.string;
import std.algorithm;
import std.array;
import std.conv;
import std.datetime;
struct S1
{
	string s="hi";
	//DateTime date;
}
void main(string[] args)
{
	alias A = Algebraic!(string[], bool[], double[]);
	A a;

	void nice(A a)
	{
		writeln(a.get[0].to!string);
	}

	auto lua=new LuaState;
	lua.openLibs();
	lua["magic"] = &nice;

	auto print = lua.get!LuaFunction("print");
	print("hello world!");
	a=["hello","helllooo"];
	print(a);
	a=[false,true,false];
	print(a);
	lua["a"]=["hello","helooo"];
	lua["nice"]=&nice;
	lua.doString(`nice(a)`);
	lua["b"]=[1,2,3];
	lua.doString(`nice(b)`);
	//S1[] arrS1 =[S1("x"),S1()];
	//lua["S1"] = arrS1;
	//lua.doString(`nice(S1[0]{"s"})`);
}