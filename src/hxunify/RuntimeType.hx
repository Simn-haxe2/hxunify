package hxunify;

typedef RuntimeClass =
{
	classType:Class<Dynamic>,
	fields:Dynamic<RuntimeType>
}

enum RuntimeType
{
	TValue(v:Type.ValueType);
	TIterable(base:RuntimeClass, param:RuntimeType);
	TObject(fields:Dynamic<RuntimeType>);
	TClass(cl:RuntimeClass);
}