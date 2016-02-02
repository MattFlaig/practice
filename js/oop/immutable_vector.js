function ImmutableVector3D(x, y, z) {

	var _x= x;
	var _y= y;
	var _z= z;


	Object.defineProperty(this, 'x', {
		get: function(){ return _x; }
	});
	Object.defineProperty(this, 'y', {
		get: function(){ return _y; }
	});
	Object.defineProperty(this, 'z', {
		get: function(){ return _z; }
	});

}


ImmutableVector3D.prototype.sum = function(deltaX, deltaY, deltaZ) {
	return new ImmutableVector3D(
		this.x + deltaX,
		this.y + deltaY,
		this.z + deltaZ
	);
};

ImmutableVector3D.equalElementsVector = function(initialValue) {
	return new ImmutableVector3D(initialValue, initialValue,initialValue);
};

ImmutableVector3D.originVector = function() {
	return ImmutableVector3D.equalElementsVector(0);
};
