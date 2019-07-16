var window = window || global;
var document = document || (window.document = {});
/***********************************/
/*http://www.layabox.com 2017/01/16*/
/***********************************/
var Laya=window.Laya=(function(window,document){
	var Laya={
		__internals:[],
		__packages:{},
		__classmap:{'Object':Object,'Function':Function,'Array':Array,'String':String},
		__sysClass:{'object':'Object','array':'Array','string':'String','dictionary':'Dictionary'},
		__propun:{writable: true,enumerable: false,configurable: true},
		__presubstr:String.prototype.substr,
		__substr:function(ofs,sz){return arguments.length==1?Laya.__presubstr.call(this,ofs):Laya.__presubstr.call(this,ofs,sz>0?sz:(this.length+sz));},
		__init:function(_classs){_classs.forEach(function(o){o.__init$ && o.__init$();});},
		__isClass:function(o){return o && (o.__isclass || o==Object || o==String || o==Array);},
		__newvec:function(sz,value){
			var d=[];
			d.length=sz;
			for(var i=0;i<sz;i++) d[i]=value;
			return d;
		},
		__extend:function(d,b){
			for (var p in b){
				if (!b.hasOwnProperty(p)) continue;
				var gs=Object.getOwnPropertyDescriptor(b, p);
				var g = gs.get, s = gs.set; 
				if ( g || s ) {
					if ( g && s)
						Object.defineProperty(d,p,gs);
					else{
						g && Object.defineProperty(d, p, g);
						s && Object.defineProperty(d, p, s);
					}
				}
				else d[p] = b[p];
			}
			function __() { Laya.un(this,'constructor',d); }__.prototype=b.prototype;d.prototype=new __();Laya.un(d.prototype,'__imps',Laya.__copy({},b.prototype.__imps));
		},
		__copy:function(dec,src){
			if(!src) return null;
			dec=dec||{};
			for(var i in src) dec[i]=src[i];
			return dec;
		},
		__package:function(name,o){
			if(Laya.__packages[name]) return;
			Laya.__packages[name]=true;
			var p=window,strs=name.split('.');
			if(strs.length>1){
				for(var i=0,sz=strs.length-1;i<sz;i++){
					var c=p[strs[i]];
					p=c?c:(p[strs[i]]={});
				}
			}
			p[strs[strs.length-1]] || (p[strs[strs.length-1]]=o||{});
		},
		__hasOwnProperty:function(name,o){
			o=o ||this;
		    function classHas(name,o){
				if(Object.hasOwnProperty.call(o.prototype,name)) return true;
				var s=o.prototype.__super;
				return s==null?null:classHas(name,s);
			}
			return (Object.hasOwnProperty.call(o,name)) || classHas(name,o.__class);
		},
		__typeof:function(o,value){
			if(!o || !value) return false;
			if(value===String) return (typeof o==='string');
			if(value===Number) return (typeof o==='number');
			if(value.__interface__) value=value.__interface__;
			else if(typeof value!='string')  return (o instanceof value);
			return (o.__imps && o.__imps[value]) || (o.__class==value);
		},
		__as:function(value,type){
			return (this.__typeof(value,type))?value:null;
		},		
		interface:function(name,_super){
			Laya.__package(name,{});
			var ins=Laya.__internals;
			var a=ins[name]=ins[name] || {self:name};
			if(_super)
			{
				var supers=_super.split(',');
				a.extend=[];
				for(var i=0;i<supers.length;i++){
					var nm=supers[i];
					ins[nm]=ins[nm] || {self:nm};
					a.extend.push(ins[nm]);
				}
			}
			var o=window,words=name.split('.');
			for(var i=0;i<words.length-1;i++) o=o[words[i]];
			o[words[words.length-1]]={__interface__:name};
		},
		class:function(o,fullName,_super,miniName){
			_super && Laya.__extend(o,_super);
			if(fullName){
				Laya.__package(fullName,o);
				Laya.__classmap[fullName]=o;
				if(fullName.indexOf('.')>0){
					if(fullName.indexOf('laya.')==0){
						var paths=fullName.split('.');
						miniName=miniName || paths[paths.length-1];
						if(Laya[miniName]) console.log("Warning!,this class["+miniName+"] already exist:",Laya[miniName]);
						Laya[miniName]=o;
					}
				}
				else {
					if(fullName=="Main")
						window.Main=o;
					else{
						if(Laya[fullName]){
							console.log("Error!,this class["+fullName+"] already exist:",Laya[fullName]);
						}
						Laya[fullName]=o;
					}
				}
			}
			var un=Laya.un,p=o.prototype;
			un(p,'hasOwnProperty',Laya.__hasOwnProperty);
			un(p,'__class',o);
			un(p,'__super',_super);
			un(p,'__className',fullName);
			un(o,'__super',_super);
			un(o,'__className',fullName);
			un(o,'__isclass',true);
			un(o,'super',function(o){this.__super.call(o);});
		},
		imps:function(dec,src){
			if(!src) return null;
			var d=dec.__imps|| Laya.un(dec,'__imps',{});
			function __(name){
				var c,exs;
				if(! (c=Laya.__internals[name]) ) return;
				d[name]=true;
				if(!(exs=c.extend)) return;
				for(var i=0;i<exs.length;i++){
					__(exs[i].self);
				}
			}
			for(var i in src) __(i);
		},
		getset:function(isStatic,o,name,getfn,setfn){
			if(!isStatic){
				getfn && Laya.un(o,'_$get_'+name,getfn);
				setfn && Laya.un(o,'_$set_'+name,setfn);
			}
			else{
				getfn && (o['_$GET_'+name]=getfn);
				setfn && (o['_$SET_'+name]=setfn);
			}
			if(getfn && setfn) 
				Object.defineProperty(o,name,{get:getfn,set:setfn,enumerable:false});
			else{
				getfn && Object.defineProperty(o,name,{get:getfn,enumerable:false});
				setfn && Object.defineProperty(o,name,{set:setfn,enumerable:false});
			}
		},
		static:function(_class,def){
				for(var i=0,sz=def.length;i<sz;i+=2){
					if(def[i]=='length') 
						_class.length=def[i+1].call(_class);
					else{
						function tmp(){
							var name=def[i];
							var getfn=def[i+1];
							Object.defineProperty(_class,name,{
								get:function(){delete this[name];return this[name]=getfn.call(this);},
								set:function(v){delete this[name];this[name]=v;},enumerable: true,configurable: true});
						}
						tmp();
					}
				}
		},		
		un:function(obj,name,value){
			value || (value=obj[name]);
			Laya.__propun.value=value;
			Object.defineProperty(obj, name, Laya.__propun);
			return value;
		},
		uns:function(obj,names){
			names.forEach(function(o){Laya.un(obj,o)});
		}
	};

	window.console=window.console || ({log:function(){}});
	window.trace=window.console.log;
	Error.prototype.throwError=function(){throw arguments;};
	String.prototype.substr=Laya.__substr;
	Object.defineProperty(Array.prototype,'fixed',{enumerable: false});

	return Laya;
})(window,document);

(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;
	/**
	*...
	*@author ww
	*/
	//class test.TestObjectHeap
	var TestObjectHeap=(function(){
		function TestObjectHeap(){
			this.test();
		}

		__class(TestObjectHeap,'test.TestObjectHeap');
		var __proto=TestObjectHeap.prototype;
		__proto.test=function(){
			var i=0,len=0;
			len=10;
			var arr;
			var heap;
			heap=new ObjectHeap();
			heap.isTopMax=false;
			heap.key=null;
			arr=[];
			for (i=0;i < len;i++){
				arr.push(Math.floor(Math.random()*100));
			}
			console.log("arr:",arr);
			for (i=0;i < len;i++){
			}
			heap.addByValueList(arr);
			var sortArr;
			sortArr=heap.popAll(true);
			console.log("sortArr:",sortArr);
		}

		return TestObjectHeap;
	})()


	/**
	*...
	*@author ww
	*/
	//class nlp.algorithm.ObjectHeap
	var ObjectHeap=(function(){
		function ObjectHeap(){
			this.key="value";
			this.idKey="id";
			this.isTopMax=true;
			this._arr=[];
		}

		__class(ObjectHeap,'nlp.algorithm.ObjectHeap');
		var __proto=ObjectHeap.prototype;
		__proto.getValueByIndex=function(index){
			var value=NaN;
			value=this.key?this._arr[index][this.key]:this._arr[index];
			if (!this.isTopMax){
				value=-value;
			}
			return value;
		}

		__proto.swap=function(i,j){
			var temp;
			temp=this._arr[i];
			this._arr[i]=this._arr[j];
			this._arr[j]=temp;
			this.updateID(i);
			this.updateID(j);
		}

		__proto.updateID=function(index){
			if (!this.key)return;
			this._arr[index][this.idKey]=index;
		}

		__proto.buildByArr=function(arr){
			this._arr=arr;
			var i=0,len=0;
			len=this._arr.length;
			for (i=0;i < len;i++){
				this.updateID(i);
			}
			for (i=this.getLastParent(len);i >=0;i--)
			this.adjustHeap(i,len);
		}

		__proto.addByValueList=function(vList){
			var i=0,len=0;
			len=vList.length;
			for (i=0;i < len;i++){
				this.addByValue(vList[i]);
			}
		}

		__proto.addByValue=function(value){
			if (!this.key){
				this.addItem(value);
				return;
			};
			var obj;
			obj={};
			obj[this.key]=value;
			this.addItem(obj);
			return obj;
		}

		__proto.addItem=function(item){
			var tIndex=0;
			tIndex=this._arr.length;
			this._arr.push(item);
			this.updateID(tIndex);
			this.adjustHeapB2T(tIndex,this._arr.length);
		}

		__proto.popTop=function(){
			if (this._arr.length < 1)return null;
			var item;
			item=this._arr[0];
			this.swap(0,this._arr.length-1);
			this._arr.length=this._arr.length-1;
			if (this._arr.length){
				this.adjustHeap(0,this._arr.length);
			}
			return item;
		}

		__proto.popAll=function(onlyValue){
			(onlyValue===void 0)&& (onlyValue=false);
			var i=0,len=0;
			len=this._arr.length;
			var rst;
			rst=[];
			var tItem;
			for (i=0;i < len;i++){
				tItem=this.popTop();
				if (onlyValue&&this.key){
					rst.push(tItem[this.key]);
					}else{
					rst.push(tItem);
				}
			}
			return rst;
		}

		__proto.removeItem=function(item){
			var tIndex=0;
			tIndex=item[this.idKey];
			if (this._arr[tIndex] !=item){
				console.log("removeitem not found:",item);
				return false;
			}
			if (tIndex==this._arr.length-1){
				this._arr.length=this._arr.length-1;
				return true;
			}
			this.swap(tIndex,this._arr.length-1);
			this._arr.length=this._arr.length-1;
			this.adjustHeap(tIndex,this._arr.length);
			this.adjustHeapB2T(tIndex,this._arr.length);
			return true;
		}

		/**
		*堆底向上调整
		*@param child
		*@param end
		*/
		__proto.adjustHeapB2T=function(child,end){
			var parent=0;
			parent=this.getParent(child);
			while (parent >=0){
				if (this.getValueByIndex(parent)< this.getValueByIndex(child)){
					this.swap(parent,child);
					child=parent;
					parent=this.getParent(child);
					}else{
					break ;
				}
			}
		}

		__proto.getLastParent=function(len){
			return Math.floor(len / 2)-1;
		}

		__proto.getParent=function(i){
			return Math.ceil(i / 2)-1;
		}

		__proto.getLeftChild=function(i){
			return i *2+1;
		}

		/**
		*堆顶向下调整
		*@param root
		*@param end
		*/
		__proto.adjustHeap=function(root,end){
			var dad=root;
			var son=this.getLeftChild(dad);
			while (son < end){
				if (son+1 < end && this.getValueByIndex(son)< this.getValueByIndex(son+1))
					son++;
				if (this.getValueByIndex(dad)> this.getValueByIndex(son))
					return;
				else {
					this.swap(dad,son);
					dad=son;
					son=this.getLeftChild(dad);
				}
			}
		}

		return ObjectHeap;
	})()



	new test.TestObjectHeap();

})(window,document,Laya);
